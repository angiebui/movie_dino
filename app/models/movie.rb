class Movie < ActiveRecord::Base
  attr_accessible :title
  has_many :showtimes
  has_many :theaters, :through => :showtimes

  def match_poster_to_database

  end

  def sync_posters

  end

  def fetch_poster!
    rotten_address = 'http://api.rottentomatoes.com/api/public/v1.0'
    rotten_api = ENV['ROTTEN_APP_ID']
    movies_json = []
    count_request = rotten_address + '/lists/movies/in_theaters.json?apikey=' + rotten_api

    total_movies = fetch_movie_count!(count_request)

    (total_movies / 50 + 1).times do |page|
      movie_search_url = rotten_address + '/lists/movies/in_theaters.json?apikey=' + rotten_api + "&page_limit=50&page=#{page + 1}"

      temp = uri_to_json(movie_search_url)
      temp['movies'].each do |movie|
        movies_json << movie
      end
    end
    puts movies_json.count
  end

  def fetch_movie_count!(count_request)
    movies_json = uri_to_json(count_request)
    movies_json['total']
  end

  def uri_to_json(url)
    uri = URI(url)
    request = Net::HTTP::get(uri)
    movies_json = JSON.parse(request)
  end
end
