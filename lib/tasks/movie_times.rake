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
    outdated.each do |theater|
      MovieTime.fetch!(zip: theater.zipcodes.first)
    end

    puts "Refreshed #{outdated.count} theatre records"
  end
end
