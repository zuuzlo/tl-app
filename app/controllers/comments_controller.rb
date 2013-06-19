class CommentsController < ApplicationController
  def new 
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comment.user_id = current_user.id
  end

  def create
    @post = Post.find(params[:post_id])
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
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    render 'posts/show'
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      flash[:success] = "Your comment has been edited and saved."
      redirect_to @post 
    else
      render 'posts/show'
    end
  end
end