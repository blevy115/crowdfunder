class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = if params[:search]
      Project.where("title ILike ?", "%#{params[:search]}%")
    else
    @projects = Project.all
    @projects = @projects.order(:end_date)
  end

  end

  def show
    @project = Project.find(params[:id])
    @claimable = @claimable
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]
    @project.start_date = params[:project][:start_date]
    @project.end_date = params[:project][:end_date]
    @project.image = params[:project][:image]

    @project.user = current_user
    @project.categories = []
    params[:project][:categories].each do |cat|
    @project.categories << Category.where("id = ?", cat)
    end




    if @project.save
      redirect_to projects_url
    else
      render :new
    end
   end

end
