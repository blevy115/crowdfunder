class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :current_user_pledge

def current_user_pledge
  if user == project.user
    errors.add(:project, "Owner should not be able to pledge towards own project")
  end
end

end
