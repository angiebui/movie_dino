module  OutingShowtime
  def valid_outing?
    params[:movies] && params[:end_time] != params[:start_time]
  end

  def fetch_new_show_times(zipcode)
    session[:jid] = zipcode.fetch_times!
    redirect_to loading_path
  end

  def showtimes(params)
    start_time, end_time = start_and_end_times(params)
    Showtime.possible_times(start_time: start_time,
                                        end_time: end_time,
                                        movie_ids: convert_to_id(params[:movies]),
                                        zipcode: current_zipcode)
  end

  def available_showtimes
    if !valid_outing?
      params[:movies] ? (flash[:notice] = "Please enter a valid time range") : (flash[:notice] = "Please select at least one movie")
    elsif showtimes = showtimes(params) and showtimes.present?
      showtimes
    else
      flash[:notice] = "Sorry, there were no showtimes available for that selection."
    end
  end

end
