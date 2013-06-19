class CategoriesController < ApplicationController

  def index
    @categories = Category.all

    if logged_in? 
      @category = Category.new
    end

  end

  def show
    @category = Category.find(params[:id])
    @posts = Post.joins(:posts_categories).where(:posts_categories => {:category_id => params[:id] }).reverse
  end

  def new
    render 'index'
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      flash[:success] = "Your category has been saved!"
      redirect_to categories_path
    else
      @categories = Category.all
      render 'index'
    end
  end
end