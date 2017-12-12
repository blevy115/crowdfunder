FactoryBot.define do
  factory :category do
    projects { |p| [p.association(:project)] }
    tag 'Art'
  end
end
