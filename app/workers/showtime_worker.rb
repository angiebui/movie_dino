class ShowtimeWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(location)
    zipcode = Zipcode.find_or_create_by_zipcode(location)
    raise ArgumentError unless zipcode
    day_workers = 8.times.map do |increment|
      sleep(0.2)
      ShowtimeDayWorker.perform_async(zipcode.zipcode, increment)
    end
    until day_workers.all?{|worker| [:complete, :failed].include? Sidekiq::Status.status(worker)}
      sleep(1)
    end

    if day_workers.all?{|worker| Sidekiq::Status.status(worker) == :complete}
      zipcode.update_attributes(cache_date: Time.now)
    end
  end
end
