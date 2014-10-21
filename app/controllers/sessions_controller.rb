require 'pry'
class SessionsController < ApplicationController

  def new
  end

  def create
    #Find user by their email
    binding.pry
    user = User.find_by(email: params[:session][:email].downcase)

    # Test if the user was found AND authenticates
    if user && user.authenticate(params[:session][:password])
      #TODO Sign In the User
    else
      flash[:error] = "Invalid email/password"
      redirect_to new_sessions_path
    end
  end

  def destroy
  end

end
