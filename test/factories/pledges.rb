FactoryBot.define do

  factory :pledge do
    dollar_amount 10.0
    user
    project

  end
end
