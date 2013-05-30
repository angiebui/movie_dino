class MovieWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(movie_id)
    raise "Invalid movie_id" unless movie_id
    movie = Movie.where(id: movie_id).first
    movie.sync_with_rotten_api
  end
end
