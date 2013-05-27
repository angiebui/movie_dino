class AddColumnsToMovies < ActiveRecord::Migration
  def change
    add_column    :movies, :poster_large,   :string
    add_column    :movies, :poster_medium,  :string
    add_column    :movies, :running_time,   :integer
    add_column    :movies, :mpaa_rating,    :string
    add_column     :movies, :critics_score,  :integer
    add_column     :movies, :audience_score, :integer
    remove_column :movies, :poster_url
  end
end
