class AddIndexToAttendeesForOutingId < ActiveRecord::Migration
  def change
    add_index :attendees, :outing_id
  end
end
