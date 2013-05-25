namespace :posters do

  desc 'sync movie posters'
  task :sync => :environment do

    movies = Movie.fetch_movie_json!
    

    movies.each do |movie|
      movie_title = movie['title'].downcase
      flicks = Movie.find_by_fuzzy_title(movie_title)
      
      match_flicks = flicks.select { |flick| flick['title'].match(movie_title) }

      unless match_flicks.empty?
        match_flicks.each do |flick|
          flick.update_attributes(:poster_url => movie['posters']['profile'])
        end
      end
    end


  end

end


# test = ['Star Trek', 'Star Trek 3D', 'Star Trek IMAX ldskafaosdfgloasfh;aoi'].match('Star Trek')
