class Movie < ActiveRecord::Base
  attr_accessible :title
  has_many :showtimes
  has_many :theaters, :through => :showtimes
end
