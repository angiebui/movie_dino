# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :zipcode do
    zipcode "12345"
    cache_date Time.now
  end

  factory :stale_zipcode, parent: :zipcode do
    cache_date Time.at 5.days.ago
  end
end