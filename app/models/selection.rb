class Selection < ActiveRecord::Base
  attr_accessible :outing_id, :attendee_id, :showtime, :selection, :movie, :theater,
    :time, :selected_count

  has_many :selecteds
  has_many :attendees, through: :selected

  belongs_to :outing
  belongs_to :showtime
  belongs_to :movie
  belongs_to :theater
end
