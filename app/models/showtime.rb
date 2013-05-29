class Showtime < ActiveRecord::Base
  attr_accessible :theater, :movie, :time
  belongs_to :movie
  belongs_to :theater
  has_many :selections

  validates_uniqueness_of :time, scope: [:movie_id, :theater_id]
  validates_presence_of :time, :movie, :theater

  def date_only
    self.time.to_date
  end

  def time_in_timezone
    zipcode = Zipcode.joins(:theaters).where('theaters.id = ?', self.theater_id).first.zipcode
    string_timezone = ActiveSupport::TimeZone.find_by_zipcode(zipcode)

    self.time.in_time_zone(string_timezone).strftime('%-l:%M%P')
  end

  def self.find_by_zipcode(zipcode)
    Showtime.joins(:theater => :zipcodes).where('zipcodes.zipcode = ?', zipcode)
  end

  def self.outdated
    today = DateTime.now
    Showtime.where('time < ?', today)
  end

  def self.possible_times(args)
    Showtime.where(:time => args[:start_time]..args[:end_time]).where(
                   :movie_id => args[:movie_ids]).select do |showtime|
      showtime.theater.zipcodes.map{|zipcode| zipcode.zipcode}.include?(args[:zipcode])
    end
  end

end
