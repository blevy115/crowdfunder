class Reward < ActiveRecord::Base
  belongs_to :project

  validates :dollar_amount, :description, presence: true








end
