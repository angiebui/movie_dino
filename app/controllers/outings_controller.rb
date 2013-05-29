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
    @jid = fetch_jid
  end

  def show
    @outing = Outing.find(params[:id])
    @showtimes = @outing.showtimes
  end

  def status
    status = Sidekiq::Status::status(params[:jid])
    render :json => {status: status.to_s}
  end

end



