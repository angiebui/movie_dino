class OutingsController < ApplicationController
  def new
    @outing = Outing.new
    @movies = Movie.limit(5)

    @time_ranges = time_range
    #TODO: days need to account for local timezone, given zipcode (currently UTC)
    @days = day_range
  end

  def create
    outing = Outing.create(user_id: current_user.id)
    start_time = get_datetime(params[:day], params[:start_time])
    end_time = get_datetime(params[:day], params[:end_time])

    movies = convert_to_id(params[:movies])

    showtimes = Showtime.possible_times(start_time: start_time, 
                                        end_time: end_time, movie_ids: movies)
    showtimes.each {|showtime| outing.selections.create(showtime: showtime)}

    redirect_to [current_user, outing]
  end

  def show
    @outing = Outing.find(params[:id])
  end

  def link_show
    @outing = Outing.find_by_link(params[:link])
    render 'show'
  end


end



