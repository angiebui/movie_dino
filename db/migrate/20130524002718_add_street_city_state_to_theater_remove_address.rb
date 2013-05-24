class AddStreetCityStateToTheaterRemoveAddress < ActiveRecord::Migration
  def change
    remove_column :theaters, :address
    add_column :theaters, :street, :string
    add_column :theaters, :city, :string
    add_column :theaters, :state, :string
  end
end
