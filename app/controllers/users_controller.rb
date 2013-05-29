class UsersController < ApplicationController
  include UsersHelper

  def show
    @outings = created_outings_data
  end

end
