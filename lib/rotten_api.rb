module RottenApi
  ROTTEN_ADDRESS = 'http://api.rottentomatoes.com/api/public/v1.0'
  ROTTEN_API = ENV['ROTTEN_APP_ID']

  def sync_with_rotten_api
    movie_address = ROTTEN_ADDRESS + '/movies.json?apikey=' + ROTTEN_API + "&q=#{self.title.gsub('[^a-zA-Z\d\s&]', '').gsub(' an imax 3d experience', '').gsub(' ', '%20')}"
    search_results = uri_to_json(movie_address)

    good_results = search_results['movies'].select {|movie| movie['release_dates']['theater'] != nil}
    good_results.reject! {|movie| Time.parse(movie['release_dates']['theater']).year > Time.now.year}

    good_results.sort_by! do |movie|
      Time.parse(movie['release_dates']['theater'])
    end

    matched_result = good_results.last

    if matched_result
      self.update_attributes(:poster_large   => matched_result['posters']['original'],
                             :synopsis       => matched_result['synopsis'],
                             :poster_med     => matched_result['posters']['profile'],
                             :runtime        => matched_result['runtime'],
                             :mpaa_rating    => matched_result['mpaa_rating'],
                             :critics_score  => matched_result['ratings']['critics_score'],
                             :audience_score => matched_result['ratings']['audience_score'])
    store_image(self.poster_large)
    end
  end

  def fetch_movie_count(count_request)
    uri_to_json(count_request)['total']
  end

  def uri_to_json(url)
    uri = URI(url)
    request = Net::HTTP::get(uri)
    response = JSON.parse(request)
  end
end
