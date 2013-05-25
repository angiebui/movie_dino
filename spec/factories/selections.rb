# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outing_selection, class: Selection do
    showtime
    association :owner, factory: :outing
  end

  factory :attendee_selection, class: Selection do
    showtime
    association :owner, factory: :attendee
  end
end
