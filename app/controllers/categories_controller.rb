class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @posts = Post.joins(:posts_categories).where(:posts_categories =>{:category_id => params[:id] })
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
  end

end