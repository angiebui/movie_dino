namespace :times do
  desc 'Cleanup old Showtimes'
  task :clean => :environment do
    outdated = Showtime.outdated
    outdated.delete_all
    puts "Deleted #{outdated.count} records."
  end
  
  desc 'Seed initial movies'
  task :slow_fetch => :environment do
    8.times do |increment|
      MovieTime.fetch!(zip: '94108', increment: increment)
    end
  end

  desc 'Refresh current theatre times'
  task :refresh => :environment do
    outdated = Theater.outdated
    outdated.each do |theater|
      ShowtimeWorker.perform_async(theater.zipcodes.first.zipcode)
    end

    puts "Refreshed #{outdated.count} theatre records"
  end

  desc 'Refresh random theater times'
  task :refresh_random => :environment do
    outdated = Zipcode.find_stale.sample
    if outdated
      ShowtimeWorker.perform_async(outdated.zipcode)
      puts "Refreshed #{outdated.zipcode}."
    else
      puts "Nothing to refresh"
    end
  end
end
