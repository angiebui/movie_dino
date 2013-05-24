# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :theater do
    name "A Theater"
    street "717 California St."
    state "CA"
    city "San Francisco"
    phone_number "(111) 111-1111"
    cache_date Time.now
  end

  factory :stale_theater, parent: :theater do
    cache_date Time.at 5.days.ago
  end
end
