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
                                attendees:     selection.fetch_attendee_list,
                                attendees_num: selection.selected_count}
      end
      compiled_selections
  end

  def fetch_attendee_data(outings)
    attendees = []
    outings.each do |outing|
      outing_pair = []
      outing[:selections].each do |selection|
        outing_pair << [ selection[:movie].title.upcase,
                         selection[:attendees_num],
                         selection[:showtime],
                         selection[:theater].name ]
      end
      attendees << outing_pair
    end
    attendees
  end

end
