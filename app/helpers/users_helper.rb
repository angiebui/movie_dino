module UsersHelper

  def created_outings_data
    outings = []
    current_user.outings.each do |outing|
      outings << {info:            outing,
                  date:            outing.date,
                  total_responses: outing.attendees.count,
                  selections:      fetch_selection_data(outing.top_selections)}
    end
    outings
  end

  def fetch_selection_data(selections)
      compiled_selections = []
      selections.each do |selection|
        compiled_selections << {theater:       selection.theater,
                                movie:         selection.movie,
                                showtime:      selection.showtime.time_in_timezone,
                                attendees_num: selection.selected_count}
      end
      compiled_selections
  end

end
