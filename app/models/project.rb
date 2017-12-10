class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :user, :title, :description, :goal, :start_date, :end_date, presence: true

  def total_pledge
  pledges = Pledge.where("project_id = ?", id)
  total_amount = pledges.pluck(:dollar_amount).sum
  return total_amount
  end

end
