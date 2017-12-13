class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true


  validate :owner_should_not_pledge_own_project

  def owner_should_not_pledge_own_project
    unless user != project.user
    errors.add(:project, 'Owner should not be able to pledge towards own project')
    end
  end


end
