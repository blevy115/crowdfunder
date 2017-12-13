class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user

    if @pledge.save
      flash[:notice] = "You have successfully backed #{@project.title}!"
      @claimable = []
      @project.rewards.each do |reward|
        if reward.dollar_amount < @pledge.dollar_amount
          @claimable << reward.id
        end
      end
      if @claimable.count > 0
      flash[:alert] = " Rewards available to be claimed on Profile page"
      end
      redirect_to project_url(@project)

    else
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end

  def claim
    @claimable = []
    @project.rewards.each do |reward|
      if reward.dollar_amount < @pledge.dollar_amount
        @claimable << reward.id
      end
    end
  end


end
