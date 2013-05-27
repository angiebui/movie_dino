class AttendeesController < ApplicationController
  def new
    @attendee = Attendee.new
    @outing = Outing.find(params[:id])
    @movies = @outing.get_movies
    @theaters = @outing.get_theaters
  end

  def create
    @attendee = Attendee.new
    @attendee.save!
    selections = convert_to_id(params[:selections])
    
    selections.each do |id|
      @attendee.selections << Selection.find(id)
    end
  end

end

