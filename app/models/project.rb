class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :user, :title, :description, :goal, :start_date, :end_date, presence: true
  validate :before_start_date_after_start_date

  def before_start_date_after_start_date
  if :start_date > current_time && :end_date > :start_date
  else
    project.errors.add(:start_date, :end_date,"date needs to be in the future", "date must be later then end date ")
  end



  private

  def current_time
    @current_time = Time.now
  end
end
