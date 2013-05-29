class Outing < ActiveRecord::Base
  attr_accessor :showtimes
  attr_accessible :user, :user_id, :result_date, :selections, :showtimes

  has_many :selections
  has_many :attendees
  has_many :showtimes, through: :selections
  has_many :theaters, through: :selections
  has_many :movies, through: :selections
  has_many :times, through: :selections

  belongs_to :user
  before_create :create_selections
  after_create :save_result_date, :outing_emails!
  before_validation :generate_link, on: :create

  validates_uniqueness_of :link

  def date
    self.selections.order('time DESC').last.time.to_date.to_formatted_s(:long_ordinal)
  end

  def get_movies
    self.movies.uniq
  end

  def get_theaters
    self.theaters.uniq
  end

  def earliest_showtime
    self.selections.order('time').first.time
  end

  def outing_emails!
    schedule_result_email unless self.result_date == nil
    send_invite_email
  end

  def posters
    self.movies.uniq[0..2].map {|movie| movie.poster_med}
  end

  def save_result_date
    time = time_until_earliest_showtime
    if time > 6
      self.result_date = self.earliest_showtime - 6.hours
      self.save
    elsif time <= 6 and time > 3
      self.result_date = self.earliest_showtime - 3.hours
      self.save
    end
  end

  def schedule_result_email
    EmailWorker.perform_at(self.result_date, self.user_id, self.id, 'result')
  end

  def send_invite_email
    EmailWorker.perform_async(self.user_id, self.id, 'invite')
  end

  def time_until_earliest_showtime
    (self.earliest_showtime - Time.now) / 3600
  end

  def top_selections
    self.selections.order('selected_count DESC').limit(3)
  end

  def zipcode
    self.showtime.first
  end

  private
  def generate_link
    self.link = SecureRandom.hex(3)
  end

  def create_selections
    showtimes.each do |showtime|
      self.selections.build(showtime: showtime,
                               movie: showtime.movie,
                               time: showtime.time,
                               theater: showtime.theater)
    end
  end
end
