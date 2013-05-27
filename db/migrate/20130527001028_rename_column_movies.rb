class RenameColumnMovies < ActiveRecord::Migration
  def change
    rename_column :movies, :running_time, :runtime
    rename_column :movies, :poster_medium, :poster_med
  end
end
