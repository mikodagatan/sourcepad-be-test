FactoryBot.define do
  factory :user do
    username { 'user1' }
    password { 'password123' }
    first_name { 'firstname' }
    last_name { 'lastname' }

    sequence(:email) { |n| "#{n}@email.com" }
  end
end
