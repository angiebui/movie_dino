class AddNameToAttendee < ActiveRecord::Migration
  def up
    add_column :attendees, :name, :string
  end

  def down
    remove_column :attendees, :name
  end
end
