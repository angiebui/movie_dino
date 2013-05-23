class CreateTheaters < ActiveRecord::Migration
  def change
    create_table :theaters do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.timestamps
    end
  end
end
