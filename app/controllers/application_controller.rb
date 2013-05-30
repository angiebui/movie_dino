class ApplicationController < ActionController::Base
  protect_from_forgery
  include TimeConverter
  include OutingShowtime
  include Authentication

  private

  def convert_to_id(hash)
    hash.values.map {|movie| movie.to_i}
  end

  def set_current_zipcode(zipcode)
    session[:zipcode] = zipcode
  end

  def current_zipcode
    session[:zipcode]
  end

  def fetch_jid
    session.delete(:jid)
  end

  helper_method :current_user, :time_range, :day_range, :get_datetime,
  :display_time, :current_timezone_string, :valid_outing?, :hours_minutes

end
