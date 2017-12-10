class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_cannot_pledge

  def owner_cannot_pledge
    if user == project.user
      errors.add(:project, "Owner should not be able to pledge towards own project")
    end
  end
end
