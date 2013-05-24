class RemoveMovieIdFromSelectionsTable < ActiveRecord::Migration
  def up
    remove_column :selections, :movie_id
  end

  def down
    add_column :selections, :movie_id, :integer
  end
end
