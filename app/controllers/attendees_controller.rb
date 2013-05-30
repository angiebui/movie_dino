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
    @attendee = Attendee.new params[:attendee]
    selections = Selection.where :id => convert_to_id(params[:selections])
    @attendee.selections << selections
    if @attendee.save
      @outing = @attendee.outing
      render :thank_you
    else
      flash[:notice] = "Please select a least one showtime!"
      render :thank_you
    end
  end

end

