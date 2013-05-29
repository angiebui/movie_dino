class AttendeesController < ApplicationController
  def new
    @attendee = Attendee.new

    if params[:link]
      @outing = Outing.find_by_link(params[:link])
    else
      @outing = Outing.find(params[:id])
    end

    @movies = @outing.get_movies
    @theaters = @outing.get_theaters
  end

  def create
    @attendee = Attendee.new(params[:attendee])
    selections = Selection.where :id => convert_to_id(params[:selections])
    @attendee.selections << selections
    if @attendee.save
      redirect_to root_path
    else
      render :new
    end
  end
  
end

