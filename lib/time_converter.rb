class DateTimeConverter

  TIMES = [ "8:00a","9:00a","10:00a","11:00a","Noon", "1:00p",
            "2:00p","3:00p","4:00p","5:00p", "6:00p", "7:00p", 
            "8:00p", "9:00p", "10:00p", "11:00p", "12:00a" ]

  def self.time_range
    values = (8..24).to_a
    TIMES.zip(values)
  end

  def self.day_range
    name_days = (2..7).to_a.map {|n| n.days.from_now.strftime('%A')}
    days = ["Today", "Tomorrow"]+ name_days
    days.zip((0..7).to_a)
  end

  def self.get_datetime(day, time)
    Chronic.parse("#{day} days from now at #{time}")
  end

end
