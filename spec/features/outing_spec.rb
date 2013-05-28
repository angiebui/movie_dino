require 'spec_helper'
require 'debugger'

describe 'Outings', :js => true do 

  before :each do 
    @zipcode = FactoryGirl.create(:zipcode)
    @theater = FactoryGirl.create(:theater)

    # need five movies to a zipcode in order to move the marquee
    @movie = FactoryGirl.create(:movie)
    @movie_two = FactoryGirl.create(:movie)
    @movie_three = FactoryGirl.create(:movie)
    @movie_four = FactoryGirl.create(:movie)
    @movie_five = FactoryGirl.create(:movie)

    @showtime = FactoryGirl.create(:showtime, {movie: @movie, theater: @theater})
    @showtime_two = FactoryGirl.create(:showtime, {movie: @movie_two, theater: @theater})
    @showtime_three = FactoryGirl.create(:showtime, {movie: @movie_three, theater: @theater})
    @showtime_four = FactoryGirl.create(:showtime, {movie: @movie_four, theater: @theater})
    @showtime_five = FactoryGirl.create(:showtime, {movie: @movie_five, theater: @theater})

    @theater.zipcodes << @zipcode

    visit root_path
    fill_in 'zipcode', with: @zipcode.zipcode
    click_button 'Start an outing'
  end

  context 'on the outings create page' do
    it 'allows you to select tomorrow for date' do
      select('Tomorrow', from: 'day')
    end

    it 'allows you to select a start_time' do
      select('1:00p', from: 'start_time')
    end

    it 'allows you to select an end_time' do
      select('10:00p', from: 'end_time')
    end

    it 'allows you to select a movie' do
      pending
      find('label[for="Sample_Movie_Title_1"]').click
    end

    it 'allows you to select multiple movies' do
      pending
      find('label[for="Sample_Movie_Title_2"]').click
      find('label[for="Sample_Movie_Title_3"]').click
    end

    it 'allows you to search through movies' do
      find(:css, 'span.marquee-next').click
    end
  end

end