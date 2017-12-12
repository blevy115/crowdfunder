FactoryBot.define do
  factory :user do
    password '12345678'
    password_confirmation '12345678'
    sequence(:email) { |u| "user#{u}@test.com"}
  end

  factory :owner, parent: :user do
    admin true
  end
end
