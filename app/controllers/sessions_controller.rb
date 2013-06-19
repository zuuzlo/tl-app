class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, success: "You successfuly logged in."
    else
      flash[:notice] = "There is something wrong with the log in."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've logged out."
  end
end