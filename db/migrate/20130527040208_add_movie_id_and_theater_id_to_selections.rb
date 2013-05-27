class AddMovieIdAndTheaterIdToSelections < ActiveRecord::Migration
  def change
    add_column :selections, :movie_id, :integer
    add_column :selections, :theater_id, :integer
  end
end
