class ShowtimeWorker
  include Sidekiq::Worker

  def perform(zipcode)
    MovieTime.fetch!(zip: zipcode)
  end
  
end
