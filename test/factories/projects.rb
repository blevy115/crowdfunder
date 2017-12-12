FactoryBot.define do

  factory :project do
    # user_id 2
    title "foo"
    description "bar"
    goal 1000
    start_date { 2.days.from_now }
    end_date { 12.days.from_now }
    user admin 
  end
end
