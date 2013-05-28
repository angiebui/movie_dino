# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    sequence(:title) {|n| "Sample Movie Title #{n}" }
    poster_large "/assets/dino_poster.jpg"
  end
end
