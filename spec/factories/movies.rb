# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :movie do
    title "Sample Movie Title"
    poster_large "/assets/dino_poster.jpg"
  end
end
