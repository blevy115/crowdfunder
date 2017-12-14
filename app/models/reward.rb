class Reward < ActiveRecord::Base
  belongs_to :project

  has_and_belongs_to_many :users

  validates :description, :dollar_amount, presence: true
  validates :dollar_amount, numericality: {greater_than: 0}

end
