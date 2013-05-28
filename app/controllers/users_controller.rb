class UsersController < ApplicationController
  def show
    @user = current_user
    @outings = current_user.outings
  end
end
