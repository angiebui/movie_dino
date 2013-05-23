class Scraper
  attr_reader :page, :increment
  def initialize(location)
    @agent = Mechanize.new
    @location = location
    open_page(@location)
    fetch_times!
  end

  def self.fetch!(args)
    if args[:zip]
      location = args[:zip]
    else
      city = args[:city].gsub(/ /,'+')
      state = args[:state].gsub(/ /,'+')
      location = "#{city},+#{state}"
    end
      Scraper.new(location)
  end

  def open_page(location, increment=0)
    @uri = URI("http://www.google.com/movies?hl=en&near=#{location}&date=#{increment}")
    @increment = increment
    @page = @agent.get @uri
  end

  def fetch_times!
    fetch_and_save_theatres
    increment = increment
    click_next_page
    next_day
  end

  def fetch_and_save_theatres
    page.root.css('div.theater').each do |theater_doc|
      theater = fetch_theater(theater_doc)
      theater_movies = theater_doc.css('div.showtimes').css('div.movie')
      theater_movies.each do |movie_doc|
        movie = fetch_movies(movie_doc)
        times_doc = movie_doc.css('div.times')
        times_doc.each do |time_doc|
          time_doc.text.gsub(/&nbsp/,'').split(' ').each do |one_time|
            time = datetime(increment,one_time)
            Showtime.create(theater:theater, movie:movie, time:time)
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
    Theater.find_or_create_by_address(name: name,
                                      address:address,
                                      phone_number:phone)
  end

  def datetime(increment, time)
    #what the heck is google giving us? string time doesn't act like a string.
    #Can't get rid of the 'white space'
    Chronic.parse("#{increment} days from now at #{time[1..-2]}")
  end

  def fetch_movies(movie_doc)
    title = movie_doc.css('div.name a').text
    Movie.find_or_create_by_title(title: title)
  end

end
