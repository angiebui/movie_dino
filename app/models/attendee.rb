class Attendee < ActiveRecord::Base
  attr_accessible :outing_id, :selecteds, :name
  
  has_many :selecteds
  has_many :selections, through: :selecteds
  belongs_to :outing
  validates_presence_of :name
  
end
