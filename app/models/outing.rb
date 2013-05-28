class Outing < ActiveRecord::Base
  attr_accessible :user, :user_id, :email_contact_date, :selections

  has_many :selections
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

  def top_selections
  end

  def earliest_showtime
    self.selections.order('time').first.time
  end

  def save_email_contact_date
    datetime = self.earliest_showtime - 6.hours
    self.email_contact_date = datetime
    self.save
  end

  private
  
  def generate_link
    self.link = SecureRandom.hex(3)
  end
  
end
