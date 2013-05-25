class Zipcode < ActiveRecord::Base
  attr_accessible :zipcode, :theater
  has_many :theaters, through: :theaters_zipcodes

end
