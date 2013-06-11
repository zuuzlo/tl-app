class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    
    if @post.save
      flash[:success] = "Your post has been saved!"
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    #flash[:success] = "Your post has been saved!"
    
    @post = Post.find(params[:id])
  end
end
