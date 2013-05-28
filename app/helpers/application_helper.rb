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

end
