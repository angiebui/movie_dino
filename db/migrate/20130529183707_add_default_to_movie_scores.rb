class AddDefaultToMovieScores < ActiveRecord::Migration
  def up
    change_column :movies, :critics_score, :integer, default: 0
    change_column :movies, :audience_score, :integer, default: 0
  end

  def down
    change_column :movies, :critics_score, :integer
    change_column :movies, :audience_score, :integer
  end
end
