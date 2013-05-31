class OutingsController < ApplicationController

  def cache
    set_current_zipcode params[:zipcode]
    zipcode = Zipcode.find_or_create_by_zipcode(current_zipcode)
    fetch_new_show_times(zipcode) and return if zipcode.stale?
    redirect_to new_outing_path
  end

  def new
    @outing = Outing.new
    @zipcode = Zipcode.find_by_zipcode(current_zipcode)
    @movies = @zipcode.movies
    @days = day_range(current_timezone_string)
  end


  def create
    showtimes = available_showtimes
    if flash[:notice]
      return redirect_to new_outing_path
    end
    outing = Outing.new(user: current_user, :showtimes => showtimes)
    if outing.save
      session[:outing_id] = outing.id
      redirect_to '/success'
    else
      render :new
    end
  end

  def loading
  end

  def status
    if session[:jids]
      @jids = session[:jids]
      completed = @jids.all?{ |jid| Sidekiq::Status.status(jid) == :complete}
      session[:jids].clear if completed
      Zipcode.where(:zipcode => session[:zipcode]).first.update_cache_date!
      render :json => {status: completed.to_s}
    else
      render :json => {status: completed.to_s}
    end
  end

  def success
    if session[:outing_id]
      @outing = Outing.find(session.delete(:outing_id))
      render :show
    else
      redirect_to root_path
    end
  end

end



