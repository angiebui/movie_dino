class RenameReferencesInSelecteds < ActiveRecord::Migration
  def up
    remove_column :selecteds, :attendees_id
    remove_column :selecteds, :selections_id
    add_column :selecteds, :attendee_id, :integer
    add_column :selecteds, :selection_id, :integer
  end

  def down
    remove_column :selecteds, :attendee_id
    remove_column :selecteds, :selection_id
    add_column :selecteds, :attendees_id, :integer
    add_column :selecteds, :selections_id, :integer
  end
end
