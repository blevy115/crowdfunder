class RewardsController < ApplicationController
  before_action :load_project

  def new
    @reward = Reward.new
  end

  def create
    @reward = @project.rewards.build
    @reward.dollar_amount = params[:reward][:dollar_amount]
    @reward.description = params[:reward][:description]

    if @reward.save
      redirect_to project_url(@project), notice: 'Reward created'
    else
      render :new
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy
    redirect_to project_url(@project)
    if @reward
      flash[:alert] = "Cannot delete reward"
    else
     flash[:alert] = 'Reward successfully removed'
   end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
    @user = current_user
  end
end
