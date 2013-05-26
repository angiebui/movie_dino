class MovieTime
  attr_reader :page, :increment, :agent

  def initialize(location)
    @zipcode = Zipcode.find_or_create_by_zipcode(location)
    @google_address = "http://www.google.com/movies?hl=en&near=#{location}&date=#{increment}"
    @agent = Mechanize.new

    @location = location
    open_page(@location)

    fetch_times!
  end

  def self.fetch!(location_data)
    if location_data[:zip]
      location = location_data[:zip]
    else
      city = location_data[:city].gsub(/ /,'+')
      state = location_data[:state].gsub(/ /,'+')
      location = "#{city},+#{state}"
    end
    MovieTime.new(location)
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
          sanitized = time_doc.text.gsub(/&nbsp/,'')
          am, pm = [], []
          if sanitized =~ /am/
            sanitized.split(' ').each_with_index do |time, index|
              if time =~ /am/
                am << index
              elsif time =~ /pm/
                pm << index
              end
            end
            pm_index = pm.first-1 || -1
            first_am = sanitized.split(' ')[0..am.first].map{|time| time =~ /am/ ? time : time + 'am'}
            first_pm = sanitized.split(' ')[am.first+1..pm_index].map{|time| time =~ /pm/ ? time : time + 'pm'}
            if am.length > 1
              second_am = sanitized.split(' ')[am.last..-1].map{|time| time =~ /am/ ? time : time + 'am'}
            end
            sanitized = first_am + first_pm + second_am
          else
            sanitized = sanitized.split(' ').map{|time| time =~ /pm/ ? time : time + 'pm'}
          end
          sanitized.each do |one_time|
            time = datetime(increment,one_time) 
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
    @zipcode.update_attributes(:cache_date => Time.now) if increment == 7
    theater
  end

  def datetime(increment, time)
    # What the heck is google giving us? 
    # String time doesn't act like a string.
    # Can't get rid of the 'white space'
    # " 10:30 "
    Chronic.parse("#{increment} days from now at #{time}")
  end

  def fetch_movies(movie_doc)
    title = movie_doc.css('div.name a').text.downcase.gsub('-', ' ')
    Movie.find_or_create_by_title(title: title)
  end

end
