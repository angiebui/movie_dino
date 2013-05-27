class Outing < ActiveRecord::Base
  attr_accessible :user, :user_id, :final_selection_id

  has_many :selections, as: :owner
  has_many :attendees
  belongs_to :user

  before_validation :generate_link, on: :create

  validates_uniqueness_of :link

  def get_movies
    self.selections.map {|s| s.showtime.movie }.uniq
  end

  private
  def generate_link
    self.link = SecureRandom.hex(3)
  end
end
