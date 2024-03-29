module TimeConverter

  TIMES = [ "8:00a","9:00a","10:00a","11:00a","Noon", "1:00p",
            "2:00p","3:00p","4:00p","5:00p", "6:00p", "7:00p",
            "8:00p","9:00p","10:00p","11:00p","12:00a" ]

  def current_timezone_string(zipcode=current_zipcode)
    ActiveSupport::TimeZone.find_by_zipcode(zipcode)
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
    local.utc
  end

  def display_time(time)
    time.in_time_zone(current_timezone_string).strftime('%-l:%M%P')
  end

  def time_range
    values = (8..24).to_a
    TIMES.zip(values)
  end

  def hours_minutes(minutes)
    if minutes
      num_hours = minutes / 60
      num_mins = minutes % 60 
      "#{num_hours}hr #{num_mins}min"
    else
      "N/A"
    end
  end

  def start_and_end_times(params)
    time_zone = ActiveSupport::TimeZone.new(current_timezone_string(current_zipcode))
    start_time = datetime_in_utc(params[:day], params[:start_time], time_zone)
    end_time = datetime_in_utc(params[:day], params[:end_time], time_zone)
    [start_time, end_time]
  end
end
