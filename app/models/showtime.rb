class Showtime < ActiveRecord::Base
  attr_accessible :theater, :movie, :time
  belongs_to :movie
  belongs_to :theater

  validates_uniqueness_of :time, scope: [:movie_id, :theater_id]
  validates_presence_of :time, :movie, :theater

  def self.outdated
    today = DateTime.now
    Showtime.where('time < ?', today)
  end
end
