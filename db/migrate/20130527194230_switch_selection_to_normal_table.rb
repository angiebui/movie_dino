class SwitchSelectionToNormalTable < ActiveRecord::Migration
  def up
    remove_column :selections, :owner_type
    remove_column :selections, :owner_id
    add_column :selections, :outing_id, :integer
  end

  def down
  end
end
