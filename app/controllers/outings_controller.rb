class OutingsController < ApplicationController

  def new
    @outing = Outing.new
    @movies = Movie.limit(5)
    titles = ["8:00a","9:00a","10:00a","11:00a","Noon","1:00p","2:00p","3:00p","4:00p","5:00p","6:00p", 
              "7:00p", "8:00p", "9:00p", "10:00p", "11:00p", "12:00a"]
    values = (8..24).to_a

    @time_ranges = titles.zip(values)
    
    # 2.days.from_now.strftime('%A') - gives you day of week 2 days from now
    # zip days to match with (0..6), 0 being "Today" and 7 being week from now

    name_days = (2..7).to_a.map {|n| n.days.from_now.strftime('%A')}
    days = ["Today", "Tomorrow"]+ name_days
    @days = days.zip((0..7).to_a)

  end

  def create
    #params => start: noon, end:  9pm, date from today (tomorrow)
    # convert to time object in ruby
    # Chronic.parse
    # start_time = 
    # end_time
    # Showtime.possible_times(start_time: start_time, end_time: end_time, movie_ids: [1,2,3,4])

  end

end



