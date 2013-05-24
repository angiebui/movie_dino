class CreateShowtimes < ActiveRecord::Migration
  def change
    create_table :showtimes do |t|
      t.timestamps
    end
  end
end
