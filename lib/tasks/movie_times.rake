namespace :times do
  desc 'Cleanup old Showtimes'
  task :clean => :environment do
    outdated = Showtime.outdated
    outdated.delete_all
    puts "Deleted #{outdated.count} records."
  end

  desc 'Refresh current theatre times'
  task :refresh => :environment do
    outdated = Theater.outdated
    cities, states = outdated.map(&:city), outdated.map(&:state)
    city_state_pairs = cities.zip(states)
    city_state_pairs.uniq.each do |city, state|
      MovieTimes.fetch!(city: city, state: state)
    end

    puts "Refreshed #{city_state_pairs.uniq.count} theatre records"
  end
end
