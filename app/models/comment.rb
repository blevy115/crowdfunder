class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :reviews, :user_id, :project_id, presence: true







end
