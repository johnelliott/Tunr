class SessionsController < ActionController::Base
  def new
  end
  def create
    # Find user by email
    user = User.find_by(email: params[:session][:email].downcase)

    # Test if the user was found 
    if user && user.authenticate(params[:session][:password])
      #TODO Sign In the User
    else
      flash[:error] = "Invalid email or password"
      redirect_to new_session_path
    end
  end
  def destroy
  end

end