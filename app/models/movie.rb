
class Movie < ActiveRecord::Base
  ROTTEN_ADDRESS = 'http://api.rottentomatoes.com/api/public/v1.0'
  ROTTEN_API = ENV['ROTTEN_APP_ID']

  after_commit :sync_after_create, :on => :create

  attr_accessible :title, :poster_large, :poster_med, :runtime, :mpaa_rating, :critics_score, :audience_score, :poster
  has_many :showtimes
  has_many :theaters, :through => :showtimes
  has_many :selections

  fuzzily_searchable :title

  def display_title
    self.title.titleize
  end

  def fetch_movie_count(count_request)
    movies_json = uri_to_json(count_request)
    movies_json['total']
  end

  def sync_after_create
    MovieWorker.perform_async(self.id)
  end

  def sync_with_rotten_api
    movie_address = ROTTEN_ADDRESS + '/movies.json?apikey=' + ROTTEN_API + "&q=#{self.title.gsub('[^a-zA-Z\d\s&]', '').gsub(' an imax 3d experience', '').gsub(' ', '%20')}"
    search_results = uri_to_json(movie_address)

    good_results = search_results['movies'].select {|movie| movie['release_dates']['theater'] != nil}
    good_results.reject! {|movie| Time.parse(movie['release_dates']['theater']).year > Time.now.year}

    good_results.sort_by! do |movie|
      Time.parse(movie['release_dates']['theater'])
    end

    matched_result = good_results.last

    self.update_attributes(:poster_large   => matched_result['posters']['original'],
                           :poster_med     => matched_result['posters']['profile'],
                           :runtime        => matched_result['runtime'],
                           :mpaa_rating    => matched_result['mpaa_rating'],
                           :critics_score  => matched_result['ratings']['critics_score'],
                           :audience_score => matched_result['ratings']['audience_score'])
    store_image(self.poster_large)
  end

  def store_image(img_url)
    bucket = AWS::S3.new.buckets['moviedino']
    image = MiniMagick::Image.open(img_url)
    image.resize('400')
    obj = bucket.objects[self.filename]
    unless obj.exists?
      obj.write(acl: :public_read, single_requiest: true, content_type: 'image/gif', data: image.to_blob)
    end
    self.update_attributes(poster: obj.public_url.to_s)
  end



  def filename
    self.title.gsub(/ /,'-')
  end

  def uri_to_json(url)
    uri = URI(url)
    request = Net::HTTP::get(uri)
    movies_json = JSON.parse(request)
  end
  
end
