FactoryBot.define do
  factory :reward do
    description Faker::Superhero.power
    dollar_amount rand(1..100)
    project
  end
end
