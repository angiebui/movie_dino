class AddPolymorphicIndexOnSelections < ActiveRecord::Migration
  def up
    add_index :selections, [:owner_id, :owner_type]
  end

  def down
    remove_index :selections, [:owner_id, :owner_type]
  end
end
