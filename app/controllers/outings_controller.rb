class OutingsController < ApplicationController

  def new
    @outing = Outing.new
    @movies = Movie.limit(12)
    # convert zipcode to appropriate time zone
    @time_zone = ActiveSupport::TimeZone.find_by_zipcode(params[:zip])
    @time_ranges = time_range

    #TODO: days need to account for local time_zone, given zipcode (currently UTC)
    @days = day_range(@time_zone)

  end

  def create
    outing = Outing.create(user_id: current_user.id)
    time_zone = ActiveSupport::TimeZone.new(params[:time_zone])
    start_time = datetime_in_utc(params[:day], params[:start_time], time_zone)
    end_time = datetime_in_utc(params[:day], params[:end_time], time_zone)

    movies = convert_to_id(params[:movies])

    showtimes = Showtime.possible_times(start_time: start_time,
                                        end_time: end_time, movie_ids: movies)
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



