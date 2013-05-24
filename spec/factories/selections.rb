# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :selection do

  end

  factory :outing_selection, class: Selection do
    showtime
    association :selectable, factory: :outing
  end

  factory :attendee_selection do
    showtime
    association :selectable, factory: :attendee
  end
end
