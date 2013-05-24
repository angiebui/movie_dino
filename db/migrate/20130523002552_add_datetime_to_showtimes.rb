class AddDatetimeToShowtimes < ActiveRecord::Migration
  def change
    add_column :showtimes, :time, :datetime
  end
end
