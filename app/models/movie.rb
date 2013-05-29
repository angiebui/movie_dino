class Movie < ActiveRecord::Base
  include RottenApi

  after_commit :sync_after_create, :on => :create

  attr_accessible :title, :poster_large, :poster_med, :runtime, :mpaa_rating,
    :critics_score, :audience_score, :poster, :synopsis
  has_many :showtimes
  has_many :theaters, :through => :showtimes
  has_many :selections


  def display_title
    self.title.titleize
  end

  def sync_after_create
    MovieWorker.perform_async(self.id)
  end

  def store_image(img_url)
    bucket = AWS::S3.new.buckets['moviedino']
    obj = bucket.objects[self.filename]
    unless obj.exists?
      image = MiniMagick::Image.open(img_url)
      image.resize('400')
      obj.write(acl: :public_read, single_requiest: true, content_type: 'image/gif', data: image.to_blob)
    end
    self.update_attributes(poster: obj.public_url.to_s)
  end

  def filename
    self.title.gsub(/ /,'-')
  end
end
