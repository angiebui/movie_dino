class ShowtimeWorker
  include Sidekiq::Worker

  def perform(zipcode)
    raise ArgumentError unless zipcode
    day_workers = 8.times.map do |increment|
      ShowtimeDayWorker.perform_async(zipcode, increment)
    end
    until day_workers.all?{|worker| [:complete, :failed].include? Sidekiq::Status.status(worker)}
      sleep(1)
    end
  end
end
