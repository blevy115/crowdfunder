FactoryBot.define do
  factory :reward do
    description Faker::Superhero.power
    dollar_amount 100
    project
  end
end
