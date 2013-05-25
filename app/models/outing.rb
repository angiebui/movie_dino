class Outing < ActiveRecord::Base
  attr_accessible :user, :user_id, :final_selection_id

  has_many :selections, :as => :owner
  has_many :attendees
  belongs_to :user

end
