class CategoriesController < ApplicationController
  
  include ActiveModel::ForbiddenAttributesProtection

  before_filter :require_user, only: [:new, :create]

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
    @categories = Category.all
    @category = Category.new
    render 'index'
  end

  def create
    #@category = Category.new(params[:category])
    
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Your category has been saved!"
      redirect_to categories_path
    else
      @categories = Category.all
      render 'index'
    end
  end

  def category_params
    params.permit(category: [:name])[:category]
  end
end