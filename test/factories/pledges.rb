FactoryBot.define do
  factory :pledge do
    dollar_amount 20
    user
    project
  end
end
