class ShowtimeWorker
  include Sidekiq::Worker

  def perform(zipcode)
    raise ArgumentError unless zipcode
    MovieTime.fetch!(zip: zipcode.to_s)
  end
  
end
