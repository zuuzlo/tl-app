class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if params[:commit] == "Self Populate"
      require 'open-uri'
      #require 'htmlentities'
      rss = SimpleRSS.parse open('http://www.osha.gov/pls/oshaweb/newsRelease.xml')
      #@post.title = HTMLEntities.new.decode(rss.items.first.title)
      item = 1 + rand(4)
      @post.title = rss.items[item].title.html_safe
      @post.description = rss.items[item].description.html_safe
      @post.url = rss.items[item].link.html_safe
      render 'edit'
    else
    
      if @post.save
        flash[:success] = "Your post has been saved!"
        redirect_to @post
      else
        render 'new'
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:success] = "Your post has been edited and saved!"
      redirect_to @post
    else
      render 'edit'
    end

  end
end
