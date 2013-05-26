class AddUniqueIndexForTheatersZipcodes < ActiveRecord::Migration
  def up
    add_index :theaters_zipcodes, [:zipcode_id, :theater_id], unique: true
  end

  def down
    remove_index :theaters_zipcodes, [:zipcode_id, :theater_id]
  end
end
