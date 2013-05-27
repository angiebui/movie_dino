require 'spec_helper'
require 'debugger'

describe 'Homepage',  :js => true do

  context 'on the index page' do
    before :each do
      visit root_path
    end

    it 'allows you to add a zipcode' do
      fill_in 'zipcode', with: '94108'
      click_button 'Start an outing'
    end

    it 'should have a Facebook login' do
      page.should have_content 'Sign in with Facebook'
    end
  end

end