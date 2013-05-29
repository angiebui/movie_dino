class ApplicationController < ActionController::Base
  protect_from_forgery
  include TimeConverter

  private

  def convert_to_id(hash)
    hash.values.map {|movie| movie.to_i}
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_zipcode
    session[:zipcode]
  end

  def fetch_jid
    session.delete(:jid)
  end

  def valid_outing?
    params[:movies] && params[:end_time] != params[:start_time]
  end

  helper_method :current_user, :time_range, :day_range, :get_datetime,
    :display_time, :current_timezone_string, :valid_outing?

end
