class ChangeSelectableToOwner < ActiveRecord::Migration
  def up
    remove_column :selections, :selectable_id
    remove_column :selections, :selectable_type
    add_column :selections, :owner_id, :integer
    add_column :selections, :owner_type, :string
  end

  def down
    add_column :selections, :selectable_id, :integer
    add_column :selections, :selectable_type, :string
    remove_column :selections, :owner_id
    remove_column :selections, :owner_type
  end
end
