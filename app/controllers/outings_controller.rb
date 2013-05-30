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
    outing = Outing.new(user: current_user, :showtimes => showtimes)
    if outing.save
      redirect_to outing
    else
      render :new
    end
  end

  def link_show
    @outing = Outing.find_by_link(params[:link])
    redirect_to outings_form(@outing)
  end

  def loading
  end

  def show
    @outing = Outing.find(params[:id])
    @showtimes = @outing.showtimes
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
end



