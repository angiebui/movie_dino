class OutingsController < ApplicationController

  def new
    @outing = Outing.new
    @movies = Movie.limit(5)
  end

  def create
   
  end

end


