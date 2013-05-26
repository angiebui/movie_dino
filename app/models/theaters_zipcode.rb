class TheatersZipcode < ActiveRecord::Base
  attr_accessible :theater, :zipcode

  belongs_to :theater
  belongs_to :zipcode
  validates_uniqueness_of :theater_id, scope: [:zipcode_id]

end
