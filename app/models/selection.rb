class Selection < ActiveRecord::Base
  attr_accessible :outing_id, :attendee_id, :showtime, :selectable

  belongs_to :selectable, :polymorphic => true
  belongs_to :showtime

end
