class CommentsController < ApplicationController
  def new 
    #@comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])
    if @comment.save
      flash[:success] = "Your comment has been saved!"
      redirect_to post_path(@post)
    else
  
     # @post.comments.pop
      render '/posts/show'
    end
  end
end