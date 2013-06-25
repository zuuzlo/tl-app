class CommentsController < ApplicationController
  before_filter :require_user 
  before_filter :find_comment, only: [:edit, :update, :vote]
  before_filter :find_comment_post, only: [:new, :create, :edit, :update, :vote]

  def new 
    
    @comment = Comment.new
    @comment.user_id = current_user.id
  end

  def create
    
    @comment = @post.comments.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Your comment has been saved!"
      redirect_to post_path(@post)
    else
  
     # @post.comments.pop
      render '/posts/show'
    end
  end

  def edit 

    render '/posts/show'
  end

  def update

    if @comment.update_attributes(params[:comment])
      flash[:success] = "Your comment has been edited and saved."
      redirect_to @post 
    else
      render '/posts/show'
    end
  end

  def vote
    unless user_voted?(@comment)
      Vote.create(user: current_user, voteable: @comment, vote: params[:vote])
    end

    respond_to do |format|
      format.html do
        flash[:success] = "Your comment vote has been saved!"
        redirect_to :back
      end

      format.js
    end
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_comment_post
    @post = Post.find(params[:post_id])
  end
end