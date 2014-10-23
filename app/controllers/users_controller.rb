class UsersController < ApplicationController
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
      sign_in @user # Sings in a newly signed up user
      redirect_to @user
    else
      render :new # Re-renders the form because of failure to add new user
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
    params.require(:user).permit( # This is a hash, the given symbol is the key, the user input is the value
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
