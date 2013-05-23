namespace :movie_times do
  desc 'Cleanup old Showtimes'
  task :clean => :environment do
    outdated = Showtime.outdated
    outdated.delete_all
    puts "Deleted #{outdated.count} records."
  end

  desc 'Refresh current theatre times' do
    task :refresh => :environment do
      
      MovieTimes.fetch!
    end
  end
end
