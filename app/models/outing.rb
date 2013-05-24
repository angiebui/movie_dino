class Outing < ActiveRecord::Base
  attr_accessible :user, :user_id, :final_selection_id

  has_many :selections, :as => :selectable
  has_many :attendees 
  belongs_to :user

end
