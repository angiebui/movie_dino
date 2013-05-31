class Selection < ActiveRecord::Base
  attr_accessible :outing_id, :attendee_id, :showtime, :selection, :movie, :theater,
    :time, :selected_count, :outing

  has_many :selecteds
  has_many :attendees, through: :selecteds

  belongs_to :outing
  belongs_to :showtime
  belongs_to :movie
  belongs_to :theater
  scope :top_picks, order('selected_count DESC')

  def fetch_attendee_list
    self.attendees.inject([]) {|list, attendee| list << attendee.name; list}
  end

end
