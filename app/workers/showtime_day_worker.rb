class ShowtimeDayWorker
  include Sidekiq::Worker

  def perform(zipcode, increment)
    MovieTime.fetch!(zip: zipcode, increment: increment)
  end
end
