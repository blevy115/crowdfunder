class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category=Category.new
    @category.tag = params[:category][:tag]
    if @category.save
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_url, notice: 'Tag successfully removed'
  end

  def index
    @categories = Category.all
  end
end
