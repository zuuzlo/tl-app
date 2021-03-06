class PostsController < ApplicationController

  include ActiveModel::ForbiddenAttributesProtection

  before_filter :find_post, only: [:show, :edit, :update, :vote]
  before_filter :require_user, only: [:new, :create, :edit, :update, :vote]

  def index
    @posts = Post.all.reverse
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    #@post = Post.new(params[:post])
    @post.user_id = current_user.id

    if params[:commit] == "Self Populate"
      auto_feed = rss_in(params[:rss]);
      @post.title = auto_feed[:title]
      @post.description = auto_feed[:description]
      @post.url = auto_feed[:url]
      render 'edit'
    else
    
      if @post.save
        #flash[:success] = "Your post has been saved!"
        redirect_to @post, :success => "Your post has been saved!"
      else
        render 'new'
      end
    end
  end

  def show
    #@post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    #@post = Post.find(params[:id])
    @comment = Comment.new
  end

  def update
    #@post = Post.find(params[:id]) 

    if @post.update_attributes(post_params)
      redirect_to @post, :success => "Your post has been edited and saved!"
    else
      render 'edit'
    end
  end

  def vote
    unless user_voted?(@post)
      Vote.create(user: current_user, voteable: @post, vote: params[:vote])
    end
    
    respond_to do |format|
      format.html do  
        flash[:success] = "Your vote has been saved!"
        redirect_to :back
      end

      format.js
    end
  end

  private

  def find_post
    #@post = Post.find_by_slug(params[:id]) 
    @post = Post.where(slug:params[:id]).first
  end

  def post_params

    params.permit(post: [:title, :description, :url, :category_ids => [] ])[:post]

  end
end
