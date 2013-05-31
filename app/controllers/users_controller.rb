class UsersController < ApplicationController
  include UsersHelper

  def show
    @outings = created_outings_data
    @attendeeJS = fetch_attendee_data(@outings)
  end

end
