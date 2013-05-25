class ApplicationController < ActionController::Base
  protect_from_forgery

  TIMES = [ "8:00a","9:00a","10:00a","11:00a","Noon", "1:00p",
            "2:00p","3:00p","4:00p","5:00p", "6:00p", "7:00p", 
            "8:00p","9:00p","10:00p","11:00p","12:00a" ]

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def time_range
    values = (8..24).to_a
    TIMES.zip(values)
  end

  def day_range
    name_days = (2..7).to_a.map {|n| n.days.from_now.strftime('%A')}
    days = ["Today", "Tomorrow"]+ name_days
    days.zip((0..7).to_a)
  end

  def get_datetime(day, time)
    Chronic.parse("#{day} days from now at #{time}")
  end

  def convert_to_id(hash)
    hash.values.map {|movie| movie.to_i}
  end

  helper_method :current_user, :time_range, :day_range, :get_datetime

end
