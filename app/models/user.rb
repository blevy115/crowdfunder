class User < ActiveRecord::Base
  has_many :comments
  has_many :projects
  has_many :pledges
  has_and_belongs_to_many :rewards
  has_secure_password


  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_pledges
    pledges = Pledge.where("user_id = ?", id)
    # total_of_pledges = 0
    projects_pledged = []
    project_total = {}
    pledges.each do |pledge|
    # total_of_pledges += pledge.dollar_amount
    project = Project.find_by("id = ?", pledge.project_id)
        if projects_pledged.include?(pledge.project_id)
          project_total[project.title][0] += pledge.dollar_amount
        else
          project_total[project.title] = [pledge.dollar_amount, project.id]
        end
       unless projects_pledged.include?(pledge.project_id)
    projects_pledged << pledge.project_id
      end
    end
    return project_total
  end

  def total_of_pledge
    total_of_pledges = 0
    pledges = Pledge.where("user_id = ?", id)
    pledges.each do |pledge|
      total_of_pledges += pledge.dollar_amount
    end
    return total_of_pledges
  end

  def total_rewards
    total_reward = {}
    self.rewards.each do |reward|
      project = Project.find_by("id = ?", reward.project.id)
      if total_reward[project.title]
        total_reward[project.title] += reward.dollar_amount
      else
        total_reward[project.title] = reward.dollar_amount
      end
    end
    return total_reward
  end

  def reward_hash
    rewards_hash = Hash.new(0)
    self.rewards.each do |reward|  
      single_reward = Reward.find_by(id:reward.id)
       rewards_hash[single_reward] += 1
    end
    return rewards_hash
  end

end
