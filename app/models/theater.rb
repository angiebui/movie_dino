class Theater < ActiveRecord::Base
  attr_accessible :name, :address, :phone_number
  has_many :showtimes
  has_many :movies, :through => :showtimes
end
