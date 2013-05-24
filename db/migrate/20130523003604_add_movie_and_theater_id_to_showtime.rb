class AddMovieAndTheaterIdToShowtime < ActiveRecord::Migration
  def change
    add_column :showtimes, :movie_id, :integer
    add_column :showtimes, :theater_id, :integer
    add_index :showtimes, [:movie_id, :theater_id, :time], :unique => true
  end
end
