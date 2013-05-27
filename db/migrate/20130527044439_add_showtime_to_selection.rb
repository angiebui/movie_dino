class AddShowtimeToSelection < ActiveRecord::Migration
  def change
    add_column :selections, :time, :datetime
  end
end
