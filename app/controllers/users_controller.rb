class UsersController < ApplicationController

  before_filter :require_user, only:[:show, :edit]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, notice: "Welcome to Health & Safety Posts! Please log in."
    else
      @user.errors.delete(:password_digest)
      render 'new'
    end
  end

  def show
    @user = current_user
    @posts = Post.where(user_id: current_user)
    @comments = Comment.where(user_id: current_user)
    if params[:view] == 'comment'
      @post_class = ''
      @comment_class = 'active'
      @comment_view = true
    else
      @post_class = 'active'
      @comment_class = ''
      @comment_view = false
    end
  end

  def edit
    @user = current_user
    render 'new'
  end
end