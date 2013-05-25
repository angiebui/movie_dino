class Attendee < ActiveRecord::Base
  attr_accessible :outing_id

  has_many :selections, :as => :owner
  belongs_to :outing
end
