class Zipcode < ActiveRecord::Base
  attr_accessible :zipcode, :theater, :cache_date

  has_many :theaters, through: :theaters_zipcodes
  has_many :theaters_zipcodes
  has_many :movies, through: :theaters, uniq: true, order: 'title'
  has_many :showtimes, through: :theaters

  validates_presence_of :zipcode

  def fetch_times!
    ShowtimeWorker.perform_async(self.zipcode)
  end

  def stale?
    return true if self.cache_date.nil?
    (Time.now - self.cache_date) > 3.days
  end

end
