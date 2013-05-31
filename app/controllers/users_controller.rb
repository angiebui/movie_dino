class UsersController < ApplicationController
  include UsersHelper

  def show
    if current_user
      @outings = created_outings_data
      @attendeeJS = fetch_attendee_data(@outings)
    else
      redirect_to root_path
    end
  end

end
