class Scraper
  def initialize(location)
    @agent = Mechanize.new
    @uri = URI("http://www.google.com/movies?hl=en&near=#{location}")
    @page = @agent.get @uri
    fetch_times!(@page)
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

  def fetch_times!(page)
    @doc = page.root.css('div.theater')
    @doc.each do |theater_doc|
      theater = fetch_theater(theater_doc)
      theater_movies = theater_doc.css('div.showtimes').css('div.movie')
      theater_movies.each do |movie_doc|
        movie = fetch_movies(movie_doc)
        times_doc = movie_doc.css('div.times')
        times_doc.each do |time_doc|
          time_doc.text.gsub(/&nbsp/,'').split(' ').each do |one_time|
            time = fetch_time(one_time)
            Showtime.create(theater:theater, movie:movie, time:time)
          end
        end
      end
    end
    page.links.each do |link|
      if link.text =~ /Next/ && link.href =~ /movies\?near/
        fetch_times!(link.click)
      end
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

  def fetch_movies(movie_doc)
    title = movie_doc.css('div.name a').text
    Movie.find_or_create_by_title(title: title)
  end

  def fetch_time(time)
    DateTime.parse(time)
  end
end
