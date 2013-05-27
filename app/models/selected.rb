class Selected < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :selection

  attr_accessible :attendee, :selection, :attendee_id, :selection_id
  after_create :update_selection_cache

  private

  def update_selection_cache
    picked = self.selection
    picked.update_attributes(selected_count: picked.selected_count + 1)
  end
  
end
