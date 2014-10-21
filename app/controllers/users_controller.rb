class Users_Controller < ApplicationController
  def index
    @users = user.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[users_params])
    if @user.save
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
