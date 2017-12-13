class RewardsController < ApplicationController
  before_action :load_project, except: :claim_reward

  def new
    @reward = Reward.new
  end

  def create
    @reward = @project.rewards.build
    @reward.dollar_amount = params[:reward][:dollar_amount]
    @reward.description = params[:reward][:description]
    @reward.limit = params[:reward][:limit]

    if @reward.save
      redirect_to project_url(@project), notice: 'Reward created'
    else
      render :new
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    if User.where("id = ?", @project.user.id).ids.join.to_i == current_user.id
      @reward.destroy
      flash[:alert] = 'Reward successfully removed'
    else
      flash[:alert] = "Cannot delete reward"
    end
    redirect_to project_url(@project)
   end

   def claim_reward
     @reward = Reward.find(params[:id])
     @user = current_user
     puts @reward.inspect
     if @reward.limit >= 1
       @reward.limit -= 1
       @reward.save
       @user.rewards << @reward
       puts @reward.limit
       redirect_to user_path(current_user)
     else
       flash[:alert] = "No more of this reward"
       redirect_to user_path(current_user)
     end
   end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end



end
