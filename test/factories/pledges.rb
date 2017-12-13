FactoryBot.define do
  factory :pledge do
    user
    project
    dollar_amount 10
  end
end
