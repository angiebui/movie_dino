class Zipcode < ActiveRecord::Base
  attr_accessible :zipcode, :theater

  has_many :theaters, through: :theaters_zipcodes
  has_many :theaters_zipcodes

end
