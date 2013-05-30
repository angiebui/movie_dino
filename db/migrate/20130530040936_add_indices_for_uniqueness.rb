class AddIndicesForUniqueness < ActiveRecord::Migration
  def up
    add_index :theaters, [:street, :name, :city, :state, :phone_number],
                          unique: true, name: 'uniqueness_index'
    add_index :movies, :title, unique: true
  end

  def down
    remove_index :theaters, [:street, :name, :city, :state, :phone_number]
    remove_index :movies, :title
  end
end
