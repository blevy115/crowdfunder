class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner
  has_and_belongs_to_many :categories

  validates :user, :title, :description, :goal, :start_date, :end_date, presence: true
  validates :goal, numericality: {greater_than: 0}

  def total_pledge
  pledges = Pledge.where("project_id = ?", id)
  total_amount = pledges.pluck(:dollar_amount).sum
  return total_amount
  end


  validates :user, :title, :description, :goal, :start_date, :end_date, presence: true
  validate :before_start_date_after_start_date

  def before_start_date_after_start_date
    if :start_date > :created_at && :end_date > :start_date
    end
  end



end
