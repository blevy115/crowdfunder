class Reward < ActiveRecord::Base
  belongs_to :project

  validates :description, :dollar_amount, presence: true
  validates :dollar_amount, numericality: {greater_than: 0}
  # before_destroy :only_owner_destroy_reward

  private

  def only_owner_destroy_reward
    # puts User.where("id = ?", self.project.user.id).inspect
    puts user
    puts "=============================="
    unless User.where("id = ?", self.project.user.id) == @current_user
    throw(:abort)
  end
  end

end
