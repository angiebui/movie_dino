class Movie < ActiveRecord::Base
  attr_accessible :title, :poster_url
  has_many :showtimes
  has_many :theaters, :through => :showtimes

  fuzzily_searchable :title

  def match_poster_to_database

  end

  def self.sync_posters
    rotten_address = 'http://api.rottentomatoes.com/api/public/v1.0'
    rotten_api = ENV['ROTTEN_APP_ID']
    movies_json = []
    matched_movies = []

    no_match = Movie.where(:poster_url => nil)
    no_match.each do |movie|

      single_request = rotten_address + '/movies.json?apikey=' + rotten_api + "&q=#{movie.title.gsub(' ', '%20').gsub(':', '').gsub('(', '').gsub(')', '').downcase}"
      temp = uri_to_json(single_request)
      
      movie.update_attributes(:poster_url => temp['movies'].first['posters']['profile'])
    end
  end

  # def self.fetch_movie_json!
  #   rotten_address = 'http://api.rottentomatoes.com/api/public/v1.0'
  #   rotten_api = ENV['ROTTEN_APP_ID']
  #   movies_json = []
  #   count_request = rotten_address + '/lists/movies/in_theaters.json?apikey=' + rotten_api

  #   total_movies = fetch_movie_count!(count_request)

  #   (total_movies / 50 + 1).times do |page|
  #     movie_search_url = rotten_address + '/lists/movies/in_theaters.json?apikey=' + rotten_api + "&page_limit=50&page=#{page + 1}"
      
  #     temp = uri_to_json(movie_search_url)

  #     temp['movies'].each do |movie|
  #       movies_json << movie
  #     end
  #   end
  #   movies_json
  # end

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
