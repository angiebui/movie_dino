class Theater < ActiveRecord::Base
  attr_accessible :name, :street, :state, :city, :phone_number, :cache_date, :zipcode, :zipcode_id
  has_many :showtimes
  has_many :movies, through: :showtimes

  has_many :zipcodes, through: :theaters_zipcodes
  has_many :theaters_zipcodes
  has_many :selections

  validates_presence_of :name, :street, :city, :state, :phone_number
  validates_uniqueness_of :street, scope: [:name, :city, :state, :phone_number]


  def self.outdated
    Theater.where('cache_date < ?', Time.now - 3.days)
  end
end
