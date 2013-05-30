class MovieTime
  attr_reader :page, :increment, :agent, :time_zone
  attr_accessor :theater, :movie

  def initialize(location, increment)
    @zipcode = Zipcode.find_or_create_by_zipcode(location)
    @agent = Mechanize.new
    @time_zone = find_time_zone
    @increment = increment
    @location = location
    open_page
    fetch_times!
  end

  def self.fetch!(location_data)
    if location_data[:zip]
      location = location_data[:zip]
    elsif location_data[:city] && location_data[:state]
      city = location_data[:city].gsub(/ /,'+')
      state = location_data[:state].gsub(/ /,'+')
      location = "#{city},+#{state}"
    else
      raise ArgumentError
    end
    MovieTime.new(location, location_data[:increment])
  end

  def find_time_zone
    tz_string = ActiveSupport::TimeZone.find_by_zipcode(@zipcode.zipcode)
    ActiveSupport::TimeZone.new(tz_string)
  end

  def google_address
    "http://www.google.com/movies?hl=en&near=#{@location}&date=#{@increment}"
  end

  def open_page
    @uri = URI(google_address)
    @page = @agent.get @uri
  end

  def fetch_times!
    fetch_and_save_theatres!
    #increment = increment
    #click_next_page
    #next_day
  end

  def fetch_and_save_theatres!
    @zipcode.update_attributes(:cache_date => Time.now) if increment == 7
    page.root.css('div.theater').each do |theater_doc|
      fetch_theater(theater_doc) # sets @theater
      if theater.cache_date
        next unless (Time.now - theater.cache_date) > 3.days
      end
      theater_movies = theater_doc.css('div.showtimes').css('div.movie')
      theater_movies.each do |movie_doc|
        fetch_movie(movie_doc)
        times_doc = movie_doc.css('div.times')
        times_doc.each do |time_doc| 
          sanitized = sanitize_time_doc(time_doc)
          sanitized.each do |one_time|
            store_time!(one_time)
          end
        end
      end
    end
  end

  def store_time!(one_time)
    time = datetime(increment,one_time)
    Showtime.create(theater: theater, 
                    movie: movie, 
                    time: time)
  end

  def sanitize_time_doc(time_doc)
    sanitized = time_doc.text.gsub(/&nbsp/,'').gsub(/\u200e/,'')
    am, pm = [], []
    if sanitized =~ /am/
      sanitized.split(' ').each_with_index do |time, index|
        if time =~ /am/
          am << index
        elsif time =~ /pm/
          pm << index
        end
      end
      pm_index = pm.first ? pm.first - 1 : -1
      first_am = sanitized.split(' ')[0..am.first].map{|time| time =~ /am/ ? time : time + 'am'}
      first_pm = sanitized.split(' ')[am.first+1..pm_index].map{|time| time =~ /pm/ ? time : time + 'pm'}
      if am.length > 1
        second_am = sanitized.split(' ')[am.last..-1].map{|time| time =~ /am/ ? time : time + 'am'}
      else
        second_am = []
      end
      sanitized = first_am + first_pm + second_am
    else
      sanitized = sanitized.split(' ').map{|time| time =~ /pm/ ? time : time + 'pm'}
    end
    sanitized
  end

  def click_next_page
    page.links.each do |link|
      if link.text =~ /Next/ && link.href =~ /movies\?near/
        fetch_times!(link.click)
      end
    end
  end

  def next_day
    if increment < 7
      open_page(@location, increment+1)
      fetch_times!
    end
  end

  def fetch_theater(theater_doc)
    name = theater_doc.children.css('h2').text
    info = theater_doc.children.css('div.info').text.sub(/-/,'|').split('|').map(&:strip)
    address, phone = info
    street, city, state = address.split(', ')
    @theater = Theater.where(name: name,
      street: street,
      city: city,
      state: state,
      phone_number: phone).first_or_create
    theater.update_attributes(:cache_date => Time.now) if increment == 7
    theater.zipcodes << @zipcode unless theater.zipcodes.include?(@zipcode)
  end

  def datetime(increment, time)
    base = time_zone.at(increment.days.from_now)
    hour, min = time.scan(/\d{1,2}/)
    if time =~ /am/
      if time =~ /12:/
        base = time_zone.at((increment+1).days.from_now)
        time = base.change :hour => '00', :min => min
      else
        time = base.change :hour => hour, :min => min
      end
    elsif time =~ /pm/
      if time =~ /12:/
        time = base.change :hour => hour, :min => min
      else
        time = base.change :hour => hour.to_i + 12, :min => min
      end
    end
    time
  end

  def fetch_movie(movie_doc)
    title = movie_doc.css('div.name a').text.downcase.gsub('-', ' ')
    self.movie = Movie.where(title: title).first_or_create
  end
end
