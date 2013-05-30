class PagesController < ApplicationController

  def index
    @outing = Outing.new
  end

  def about
  end
end
