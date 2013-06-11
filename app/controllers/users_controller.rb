class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    flash[:success] = "Welcome to EHS "
    @user = User.find(param[:id])
  end
end