# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showtime do
    movie
    theater
    sequence(:time) {|n| Time.now + n}
  end
end
