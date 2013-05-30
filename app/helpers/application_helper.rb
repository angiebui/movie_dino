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

  def default_poster
    "http://www.google.com/imgres?um=1&sa=N&hl=en&biw=1212&bih=1009&tbm=isch&tbnid=4K3ZkQGE-2zC1M:&imgrefurl=http://www.tumblr.com/tagged/cute%2520dinosaurs&docid=rGcbLI-LevhDOM&imgurl=http://25.media.tumblr.com/tumblr_lffzt5IUZD1qgvv79o1_500.jpg&w=500&h=326&ei=_sinUeWBJMaQiQKD0ICQBA&zoom=1&iact=rc&dur=19&page=1&tbnh=181&tbnw=278&start=0&ndsp=29&ved=1t:429,r:0,s:0&tx=224&ty=107"
  end

end
