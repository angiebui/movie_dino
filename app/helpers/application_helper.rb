module ApplicationHelper
  def build_marquee(movie, index)
    index += 1
    if index % 4 == 1
      "<li class='row'>" +
        "<div class='large-3 columns'>" +
          "<div class='panel' style='background-image: url(" + movie.poster_url + ");'></div>" +
        "</div>"
    elsif index % 4 == 0
        "<div class='large-3 columns'>" +
          "<div class='panel' style='background-image: url(" + movie.poster_url + ");'></div>" +
        "</div>" +
      "</li>"
    else
      "<div class='large-3 columns'>" +
        "<div class='panel' style='background-image: url(" + movie.poster_url + ");'></div>" +
      "</div>"
    end
  end


  def show_created_events
    outings = []
    current_user.outings.each do |outing|
      outings << [Movie.where(id: outing.final_selection_id).first.title.upcase,
                  outing.created_at.to_date.to_formatted_s(:long_ordinal)]
    end
    outings
  end
end
