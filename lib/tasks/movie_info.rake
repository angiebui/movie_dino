namespace :movies do
  desc 'Resync all movie info'
  task :sync => :environment do
    movies = Movie.all
    movies.each do |movie|
      movie.sync_after_create
    end
  end
end
