class Selection < ActiveRecord::Base
  attr_accessible :outing_id, :attendee_id

  belongs_to :selectable, :polymorphic => true

end
