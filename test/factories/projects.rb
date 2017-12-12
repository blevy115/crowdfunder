FactoryBot.define do
  factory :project do
    association :user, factory: :owner
    title 'Project'
    description 'My project'
    goal 50
    start_date DateTime.now
    end_date DateTime.now + 1.day
  end
end
