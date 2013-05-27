class AttendeesController < ApplicationController
  def new
    @attendee = Attendee.new
    @outing = Outing.find(params[:id])
    @movies = @outing.get_movies
    @theaters = @outing.get_theaters
  end

  def create
    @attendee = Attendee.new
    @attendee.save
    selections = params[:selections]
    selections.each do |selection|
    p "Hash?"
    # debugger
    p selection[1]
      # @attendee.selections.create(selection[0])
    end
  end

end

