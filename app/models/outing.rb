class Outing < ActiveRecord::Base
  attr_accessible :user, :user_id, :final_selection_id

  has_many :selections, as: :owner
  has_many :attendees
  has_many :showtimes, through: :selections
  has_many :theaters, through: :selections
  has_many :movies, through: :selections
  has_many :times, through: :selections
  belongs_to :user

  before_validation :generate_link, on: :create

  validates_uniqueness_of :link

  def get_movies
    self.movies.uniq
  end

  def get_theaters
    self.theaters.uniq
  end

  private
  def generate_link
    self.link = SecureRandom.hex(3)
  end
end
