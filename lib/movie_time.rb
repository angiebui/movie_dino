class MovieTime
  attr_reader :page, :increment, :agent, :time_zone

  def initialize(location)
    @zipcode = Zipcode.find_or_create_by_zipcode(location)
    @google_address = "http://www.google.com/movies?hl=en&near=#{location}&date=#{increment}"
    @agent = Mechanize.new
    @time_zone = find_time_zone

    @location = location
    open_page(@location)

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
    MovieTime.new(location)
  end

  def find_time_zone
    tz_string = ActiveSupport::TimeZone.find_by_zipcode(@zipcode.zipcode)
    ActiveSupport::TimeZone.new(tz_string)
  end

  def fetch_posters!

  end

  def open_page(location, increment = 0)
    @uri = URI(@google_address)
    @increment = increment
    @page = @agent.get @uri
  end

  def fetch_times!
    fetch_and_save_theatres!
    increment = increment
    click_next_page
    next_day
  end

  def fetch_and_save_theatres!
    @zipcode.update_attributes(:cache_date => Time.now) if increment == 7
    page.root.css('div.theater').each do |theater_doc|
      theater = fetch_theater(theater_doc)

      if theater.cache_date
        next unless (Time.now - theater.cache_date) > 3.days
      end

      theater.update_attributes(:cache_date => Time.now) if increment == 7
      theater_movies = theater_doc.css('div.showtimes').css('div.movie')
      theater_movies.each do |movie_doc|
        movie = fetch_movies(movie_doc)
        times_doc = movie_doc.css('div.times')
        times_doc.each do |time_doc|
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
          sanitized.each do |one_time|
            time = datetime(increment,one_time) 
            debugger
            Showtime.create(theater: theater, movie: movie, time: time)
          end
        end
      end
    end
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
    theater = Theater.where(name: name,
                  street: street,
                  city: city,
                  state: state,
                  phone_number: phone).first_or_create
    theater.zipcodes << @zipcode unless theater.zipcodes.include?(@zipcode)
    theater
  end

  def datetime(increment, time)
    # Chronic.parse("#{increment} days from now at #{time}")
    base = time_zone.at(increment.days.from_now)
    hour, min = time.scan(/\d{1,2}/)
    if time =~ /am/
      if time =~ /12:/
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
    debugger
    time
  end

  def fetch_movies(movie_doc)
    title = movie_doc.css('div.name a').text.downcase.gsub('-', ' ')
    Movie.find_or_create_by_title(title: title)
  end

end
