# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'email@example.com'
    first_name 'Robby'
    last_name 'Bobby'
    image 'http://www.example.com/1'
  end
end
