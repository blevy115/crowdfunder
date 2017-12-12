FactoryBot.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    admin false
    password "12345678"
    password_confirmation "12345678"
    sequence(:email) { |n| "person#{n}@example.com" }

  end

  factory :admin, class: User do
    first_name "Admin"
    last_name  "User"
    admin      true
  end
end
