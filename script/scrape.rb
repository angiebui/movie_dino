require_relative '../config/boot'
require_relative '../config/environment'

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://google.com/movies?near=san+francisco'))


#doc.xpath('//*[@class="desc"]/h2').each{|th| p th.text}
doc.css('div.theater').each do |stuff|
  theater_name = stuff.children.css('h2').text
  info = stuff.children.css('div.info').text.sub(/-/,'|').split('|').map(&:strip)
  theater_address, theater_phone = info
  theater = Theater.find_or_create_by_name(name: theater_name, address: theater_address, phone_number: theater_phone)
  stuff.children.css('div.showtimes').css('div.movie').each do |movie|
    title = movie.css('div.name a').text
    movie_obj = Movie.find_or_create_by_title(title: title)
    movie.css('div.times').each do |time|
      time.text.gsub(/&nbsp/,'').split(' ').each do |a_time|
        time = DateTime.parse(a_time.strip)
        showtime = Showtime.create(theater: theater, movie: movie_obj, time: time)
      end
    end
  end
end
