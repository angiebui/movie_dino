class TheatersZipcode < ActiveRecord::Base
  attr_accessible :theater, :zipcode

  belongs_to :theater
  belongs_to :zipcode

end
