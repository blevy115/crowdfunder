FactoryBot.define do
  factory :user do
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "person#{n}@unique.com" }
  end

  factory :admin, parent: :user do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
  
end
