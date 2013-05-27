require 'spec_helper'
require 'debugger'

describe 'Outings', :js => true do 
  before :each do
    visit root_path
    fill_in 'zipcode', with: '94108'
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
  end


end