class OutingsController < ApplicationController

  def cache
    session[:zipcode] = params[:zipcode]
    @zipcode = params[:zipcode]
    zipcode = Zipcode.find_or_create_by_zipcode(@zipcode)

    if zipcode.stale?
      jid = zipcode.fetch_times!
      session[:jid] = jid
      redirect_to loading_path
    else
      redirect_to new_outing_path
    end
  end

  def create
    if !valid_outing?
      flash[:notice] = "Sorry, that wasn't a valid selection"
      return redirect_to new_outing_path
    end
    outing = Outing.new(user_id: current_user.id)
    time_zone = ActiveSupport::TimeZone.new(params[:time_zone])
    start_time = datetime_in_utc(params[:day], params[:start_time], time_zone)
    end_time = datetime_in_utc(params[:day], params[:end_time], time_zone)

    movies = convert_to_id(params[:movies])

    showtimes = Showtime.possible_times(start_time: start_time,
                                        end_time: end_time, movie_ids: movies,
                                        zipcode: current_zipcode)
    if showtimes.empty?
      flash[:notice]="Sorry, there were no showtimes available for that selection."
      return redirect_to new_outing_path
    else
      showtimes.each do |showtime|
        outing.selections.create(showtime: showtime,
                                 movie: showtime.movie,
                                 time: showtime.time,
                                 theater: showtime.theater)
      end
      outing.save_result_date
      redirect_to outing
    end
  end

  def link_show
    @outing = Outing.find_by_link(params[:link])
    render 'show'
  end

  def loading
    @jid = fetch_jid
  end

  def new
    @outing = Outing.new
    @zipcode = Zipcode.find_by_zipcode(current_zipcode)
    @movies = @zipcode.movies

    @time_zone = ActiveSupport::TimeZone.find_by_zipcode(current_zipcode)
    @time_ranges = time_range
    @days = day_range(@time_zone)
  end


  def show
    @outing = Outing.find(params[:id])
    @showtimes = @outing.showtimes
  end

  def status
    status = Sidekiq::Status::status(params[:jid])
    p status
    render :json => {status: status.to_s}
  end

end



