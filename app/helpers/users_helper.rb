module UsersHelper

  def created_outings_data
    outings = {}
    current_user.outings.each do |outing|
      outings.merge!(outing.id => outing.top_selections)
    end
    outings
  end

  def style_outings_data
    @outings.each_key do |outing|
      puts 'OUTING BELOW$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
      puts Outing.where(id: outing)
      @outings[outing].each do |selection|
        puts selection
      end
    end
  end

end
