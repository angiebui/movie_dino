class ApplicationController < ActionController::Base
  protect_from_forgery

  TIMES = [ "8:00a","9:00a","10:00a","11:00a","Noon", "1:00p",
            "2:00p","3:00p","4:00p","5:00p", "6:00p", "7:00p", 
            "8:00p","9:00p","10:00p","11:00p","12:00a" ]

  private

  def convert_to_id(hash)
    hash.values.map {|movie| movie.to_i}
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_timezone_string
    ActiveSupport::TimeZone.find_by_zipcode(current_zipcode)
  end

  def current_zipcode
    session[:zipcode]
  end

  def day_range(time_zone)
    name_days = (2..7).to_a.map.each do |n|
      Time.use_zone(time_zone) { n.days.from_now.strftime('%A') }
    end

    days = ["Today", "Tomorrow"]+ name_days
    days.zip((0..7).to_a)
  end

  def datetime_in_utc(day, time, time_zone)
    local = time_zone.at(day.to_i.days.from_now).change(:hour => time.to_i)
    p local
    local.utc
  end

  def display_time(time)
    time.in_time_zone(current_timezone_string).strftime('%l:%M%P')
  end

  def time_range
    values = (8..24).to_a
    TIMES.zip(values)
  end
  helper_method :current_user, :time_range, :day_range, :get_datetime, 
    :display_time, :current_timezone_string

end
