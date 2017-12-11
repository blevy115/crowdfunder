Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all
Category.destroy_all


Category.create(tag: "Music")
Category.create(tag: "TV")
Category.create(tag: "Art")



5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

10.times do
  project = Project.create!(
              title: Faker::App.name,
              description: Faker::Lorem.paragraph,
              goal: rand(100000),
              start_date: Time.now.utc - rand(60).days,
              end_date: Time.now.utc + rand(10).days,
              user: User.first
            )

  5.times do
    project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(1..100),
    )
  end
end


20.times do
  project = Project.all.sample

  Pledge.create!(
    user: User.all.where("id > ?", 1).sample,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(1..10)
  )
end
