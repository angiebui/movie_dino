class RemoveFinalSelectionIdFromOutings < ActiveRecord::Migration
  def up
    remove_column :outings, :final_selection_id 
    add_column :outings, :email_contact_date, :datetime
  end

  def down
    add_column :outings, :final_selection_id, :integer
    remove_column :outings, :email_contact_date
  end
end
