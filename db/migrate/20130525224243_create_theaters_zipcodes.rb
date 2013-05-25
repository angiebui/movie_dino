class CreateTheatersZipcodes < ActiveRecord::Migration
  def change
    create_table :theaters_zipcodes do |t|
      t.references :zipcode
      t.references :theater
      t.timestamps
    end

    add_index :theaters_zipcodes, :zipcode_id
  end
end
