FactoryBot.define do
  factory :category do
    projects {[association(:project)]}
  end
end
