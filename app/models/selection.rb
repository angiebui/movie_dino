class Selection < ActiveRecord::Base
  attr_accessible :outing_id, :attendee_id, :showtime, :owner, :movie, :theater

  belongs_to :owner, :polymorphic => true
  belongs_to :showtime
  belongs_to :movie
  belongs_to :theater

end
