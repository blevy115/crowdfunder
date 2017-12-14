class CommentsController < ApplicationController
  before_action :load_project
  before_action :require_login
  before_action :ensure_user_owns_comment, only: [:edit, :update, :destroy]

  def load_project
    @project = Project.find(params[:project_id])
  end

  def ensure_user_owns_comment
    unless current_user == Comment.find(params[:id]).user
      flash[:alert] = "You are not authorized to edit this comment!"
      redirect_to project_url(@project)
    end
  end

  def show
    @comment = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new
    @comment.content = params[:comment][:content]
    @comment.project_id = params[:project_id]
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "comment added to #{@project.title}"
      redirect_to project_url(@project)
    else
      flash[:alert] = "Sorry, there was a problem adding your comment"
      redirect_to project_url(@project)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def update
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @comment.content = params[:content]
    @comment.project_id = params[:project_id]
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Your comment has been updated for #{@comment.project.title}"
      redirect_to project_url(@project)
    else
      flash[:alert] = "Sorry, there was a problem updating your comment"
      redirect_to project_url
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "You have successfully deleted your comment"
    redirect_to projects_url
  end

end
