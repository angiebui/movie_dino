class Zipcode < ActiveRecord::Base
  attr_accessible :zipcode, :theater, :cache_date

  has_many :theaters, through: :theaters_zipcodes
  has_many :theaters_zipcodes


  def stale?
    return true unless self.cache_date
    (Time.now - self.cache_date) > 3.days
  end

end
