class ShowtimeDayWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(zipcode, increment)
    MovieTime.fetch!(zip: zipcode, increment: increment)
  end
end
