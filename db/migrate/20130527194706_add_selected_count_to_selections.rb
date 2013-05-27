class AddSelectedCountToSelections < ActiveRecord::Migration
  def change
    add_column :selections, :selected_count, :integer, default: 0
  end
end
