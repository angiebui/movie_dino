class OutingsController < ApplicationController

  def new
    @outing = Outing.new
    @movies = Movie.limit(5)
    # converts zipcode to appropriate timezone
    session[:zipcode] = params[:zipcode]
    @zipcode = params[:zipcode]
    @time_zone = ActiveSupport::TimeZone.find_by_zipcode(@zipcode)
    @time_ranges = time_range
    @days = day_range(@time_zone)

    zipcode = Zipcode.find_or_create_by_zipcode(@zipcode)

    if zipcode.stale?
      # needs a spinner before entering the form 
      # movies that display are based off of where the user is
      # we show all movies that are displayed nearby, ordered by rank
      ShowtimeWorker.perform_async(@zipcode)
    end
  end

  def create
    outing = Outing.create(user_id: current_user.id)
    time_zone = ActiveSupport::TimeZone.new(params[:time_zone])
    start_time = datetime_in_utc(params[:day], params[:start_time], time_zone)
    end_time = datetime_in_utc(params[:day], params[:end_time], time_zone)

    movies = convert_to_id(params[:movies])

    showtimes = Showtime.possible_times(start_time: start_time,
                                        end_time: end_time, movie_ids: movies,
                                        zipcode: current_zipcode)

    p "current zipcode"
    p current_zipcode
    
    p "SHOWTIMES?" 
    p showtimes

    showtimes.each {|showtime| outing.selections.create(showtime: showtime)}

    redirect_to outing
  end

  def show
    @outing = Outing.find(params[:id])
  end

  def link_show
    @outing = Outing.find_by_link(params[:link])
    render 'show'
  end

end



