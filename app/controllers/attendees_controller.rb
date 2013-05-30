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
    @outing = @attendee.outing

    if @attendee.save
      selections = Selection.where :id => convert_to_id(params[:selections])
      @attendee.selections << selections
      render :thank_you
    else
      flash[:notice] = "Please select at least one showtime."
      redirect_to outings_form_path(@outing.link)
    end
  end

end

