class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
    params[:user][:user_name],
    params[:user][:password]
    )
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:messages] = ["Invalid login credentials"]
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_sessions_url
    end
  end

end
