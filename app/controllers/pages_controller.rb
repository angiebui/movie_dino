class PagesController < ApplicationController

  def index
    @outing = Outing.new
  end
  
end
