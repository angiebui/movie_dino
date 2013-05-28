module UsersHelper

  def created_outings_data
    outings = []
    count = 0
    current_user.outings.each do |outing|
      outings << {:"outing_#{count}" => {:selections => outing.top_selections}}
      count += 1
    end
    outings
  end

end
