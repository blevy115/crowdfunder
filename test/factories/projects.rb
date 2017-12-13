FactoryBot.define do
  factory :project do
    association :user, factory: :admin
    title "Best project ever!"
    description Faker::Lorem.paragraph
    goal 100000
    start_date DateTime.now.utc
    end_date DateTime.now.utc + 1.month
  end
end
