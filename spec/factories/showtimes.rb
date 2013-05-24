# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showtime do
    movie
    theater
    time Time.now
  end
end
