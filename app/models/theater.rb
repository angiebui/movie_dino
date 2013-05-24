class Theater < ActiveRecord::Base
  attr_accessible :name, :address, :phone_number, :cache_date
  has_many :showtimes
  has_many :movies, :through => :showtimes

  def self.outdated
    Theater.where('cache_date < ?', Time.now - 3.days)
  end
end
