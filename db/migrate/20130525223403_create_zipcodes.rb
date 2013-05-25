class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :zipcode

      t.timestamps
    end

    add_index :zipcodes, :zipcode 
  end
end
