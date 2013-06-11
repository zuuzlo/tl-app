class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    if @comment.save
      flash[:success] = "Your comment has been saved!"
      redirect_to post_path(@post)
    else
      binding.pry
      render '/posts/show'
    end
  end
end