namespace :posters do

  desc 'sync movie posters'
  task :sync => :environment do
    title_extension {}

    movies = Movie.fetch_movie_json!

    movies.each do |movie|
      flick = Movie.where('title LIKE ?', movie['title']).first
      flick.update_attributes(:poster_url => movie['posters']['profile']) if flick
    end
  end

end
