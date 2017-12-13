class CommentsController < ApplicationController
  before_action :ensure_logged_in

  def show
    @comment = Comment.all
  end

  def new
    @comment = Comment.new
    @project = Project.find(params[:project_id])
  end

  def create
    @comment = Comment.new
    @project = Project.find(params[:project_id])
    @comment.reviews = params[:comment][:reviews]
    @comment.date_posted = params[:comment][:date_posted]
    @comment.project_id = params[:project_id]
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "comment added to #{@project.title}"
      redirect_to project_url(@project)
    else
        flash.now[:alert] = "Sorry, there was a problem adding your comment"
        render 'projects'
    end
  end

  def edit
    @comments = current_user.comments
    @project = Project.find(params[:project_id])
  end


  def update
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    @comment.text = params[:comment][:text]
    @comment.date_posted = params[:comment][:date_posted]

    if @comment.save
      flash[:success] = "Your comment has been updated for #{@comment.project.name}"
      redirect_to root_url
    else
        flash.now[:alert] = "Sorry, there was a problem updating your comment"
        render 'projects'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "You have successfully deleted your comment"
    redirect_to projects_url

  end


  def ensure_logged_in
    unless current_user
      flash[:alert] = "You must be logged in to comment"
      redirect_to projects_url
    end
  end
end
