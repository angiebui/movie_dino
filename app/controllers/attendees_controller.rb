class AttendeesController < ApplicationController
  def new
    @attendee = Attendee.new
    @outing = Outing.find(params[:id])
    @movies = @outing.get_movies
    @theaters = @outing.get_theaters
  end

  def create
    @attendee = Attendee.new(params[:attendee])
    if @attendee.save
      selections = convert_to_id(params[:selections])
      selections.each {|id| @attendee.selections << Selection.find(id) }

      redirect_to root_path
    else
      # show errors 
    end
  end

end

