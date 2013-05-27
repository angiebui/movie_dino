class RenameSelectedTable < ActiveRecord::Migration
  def up
    rename_table :selected, :selecteds
  end

  def down
    rename_table :selecteds, :selected
  end
end
