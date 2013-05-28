class MovieWorker
  include Sidekiq::Worker

  def perform(movie_id)
    movie = Movie.where(id: movie_id).first
    movie.sync_with_rotten_api
  end
  
end
