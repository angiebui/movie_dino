class UsersController < ApplicationController
  include UsersHelper

  def show
    @user = current_user
    @outings = created_outings_data
  end

end
