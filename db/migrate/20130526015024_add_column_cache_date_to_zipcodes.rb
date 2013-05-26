class AddColumnCacheDateToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :cache_date, :datetime
  end
end
