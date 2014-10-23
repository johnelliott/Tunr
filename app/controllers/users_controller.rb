class UsersController < ApplicationController
  # Require signin if the user does anything that activcates the users controller
  before_action :require_signin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
  end
  def edit
  end
  def update
  end
  def destroy
  end
 private
  def users_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
