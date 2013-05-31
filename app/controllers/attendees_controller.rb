class AttendeesController < ApplicationController

  def index
    if session[:outing_id]
      @outing = Outing.find(session.delete(:outing_id))
      render :thanks
    else
      redirect_to root_path
    end
  end

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
      session[:outing_id] = @outing.id
      redirect_to '/thanks'
    else
      flash[:notice] = "Please select at least one showtime."
      redirect_to outings_form_path(@outing.link)
    end
  end

end

