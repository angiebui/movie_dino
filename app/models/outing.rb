class Outing < ActiveRecord::Base
  attr_accessible :user, :user_id, :email_contact_date

  has_many :selections
  has_many :attendees
  has_many :showtimes, through: :selections
  has_many :theaters, through: :selections
  has_many :movies, through: :selections
  has_many :times, through: :selections
  belongs_to :user

  before_validation :generate_link, on: :create
  # after_create :save_email_contact_date

  validates_uniqueness_of :link

  def get_movies
    self.movies.uniq
  end

  def get_theaters
    self.theaters.uniq
  end

  def top_selections
  end

  private
  
  def generate_link
    self.link = SecureRandom.hex(3)
  end

  # def save_email_contact_date
  #   self.selections.order()
  #   self.email_contact_date =
  # 
  # end

end
