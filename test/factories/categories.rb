FactoryBot.define do
  factory :category do
    projects { |p| [p.association(:project)] }
  end
end
