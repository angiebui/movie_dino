class Attendee < ActiveRecord::Base
  attr_accessible :outing_id
  has_many :selected
  has_many :selections, through: :selected
  belongs_to :outing
end
