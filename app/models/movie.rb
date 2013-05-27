class Movie < ActiveRecord::Base
  ROTTEN_ADDRESS = 'http://api.rottentomatoes.com/api/public/v1.0'
  ROTTEN_API = ENV['ROTTEN_APP_ID']

  attr_accessible :title, :poster_large, :poster_med, :runtime, :mpaa_rating, :critics_score, :audience_score
  has_many :showtimes
  has_many :theaters, :through => :showtimes

  fuzzily_searchable :title

  def match_poster_to_database

  end

  def self.sync_movie
    not_synced = Movie.where(:poster_large => nil,
                           :poster_med => nil,
                           :runtime => nil,
                           :mpaa_rating => nil,
                           :critics_score => nil,
                           :audience_score => nil)
    not_synced.each do |movie|

      single_movie_address = ROTTEN_ADDRESS + '/movies.json?apikey=' + ROTTEN_API + "&q=#{movie.title.gsub('[^a-zA-Z\d\s&]', '').gsub(' an imax 3d experience', '').gsub(' ', '%20')}"
      search_results = uri_to_json(single_movie_address)
      matched_result = search_results['movies'].first
      
      movie.update_attributes(:poster_large   => matched_result['posters']['original'],
                              :poster_med     => matched_result['posters']['profile'],
                              :runtime        => matched_result['runtime'],
                              :mpaa_rating    => matched_result['mpaa_rating'],
                              :critics_score  => matched_result['ratings']['critics_score'],
                              :audience_score => matched_result['ratings']['audience_score'])
    end
  end

  def self.fetch_movie_json!
    movies_json = []
    count_request = ROTTEN_ADDRESS + '/lists/movies/in_theaters.json?apikey=' + ROTTEN_API

    total_movies = fetch_movie_count!(count_request)

    (total_movies / 50 + 1).times do |page|
      movie_search_url = ROTTEN_ADDRESS + '/lists/movies/in_theaters.json?apikey=' + ROTTEN_API + "&page_limit=50&page=#{page + 1}"
      
      temp = uri_to_json(movie_search_url)

      temp['movies'].each do |movie|
        movies_json << movie
      end
    end
    movies_json
  end

  def self.fetch_movie_count!(count_request)
    movies_json = uri_to_json(count_request)
    movies_json['total']
  end

  def self.uri_to_json(url)
    uri = URI(url)
    request = Net::HTTP::get(uri)
    movies_json = JSON.parse(request)
  end
end

class NoPostersError < StandardError
end
