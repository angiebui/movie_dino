require 'spec_helper'
require 'debugger'

describe 'Outings', :js => true do 

  before :each do 
    @zipcode = FactoryGirl.create(:zipcode)
    @theater = FactoryGirl.create(:theater)
    @movie = FactoryGirl.create(:movie)
    @showtime = FactoryGirl.create(:showtime, {movie: @movie, theater: @theater})

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
      debugger
      
    end

    it 'allows you to select multiple movies' do
      pending
    end

    it 'allows you to search through movies' do
      find('marquee-next').click
    end
  end


end