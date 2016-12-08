class UsersController < ApplicationController
  before_action :require_no_user!

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:messages] = @user.errors.full_messages
      redirect_to new_sessions_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
