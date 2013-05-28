class SessionsController < ApplicationController

  def create
    user = User.find_or_create_user_by_token(params)
    session[:user_id] = user.id
    if user.errors.empty?
      render json: {result: 'success'}, status: :ok
    else
      render json: {result: 'errors'}, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def index
  end
end
