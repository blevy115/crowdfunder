Pledge.destroy_all
Reward.destroy_all
User.destroy_all
Project.destroy_all

5.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
  puts "user #{user.first_name} created"
end

10.times do
  project = Project.create!(
              title: Faker::App.name,
              description: Faker::Lorem.paragraph,
              goal: rand(100000),
              start_date: Time.now.utc - rand(60).days,
              end_date: Time.now.utc + rand(10).days,
              user: User.all.sample
            )
              puts "project #{project.title} created"
  5.times do
  reward = project.rewards.create!(
      description: Faker::Superhero.power,
      dollar_amount: rand(1..100),
      limit: rand(1..10)

    )
      puts "reward #{reward.description} created"
  end
end


20.times do
  project = Project.all.sample
  # user = User.all.sample
  #   until user != project.user do
  #     user = User.all.sample
  #   end
    # user = (User.all - project.user).sample
  pledge = Pledge.create!(
    user: (User.all - [project.user]).sample,
    project: project,
    dollar_amount: project.rewards.sample.dollar_amount + rand(10)
  )
    puts "#{pledge.user.first_name} backs #{pledge.project.title} for #{pledge.dollar_amount}"
end
