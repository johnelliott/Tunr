module SessionsHelper
  #TODO Write me!
  def current_user
    remember_token = User.hash(cookies[:remember_token]) #will ask the client's browser for the contents of the cookie(a hash)
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    current_user == user
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token)) #does a partial update where only the password field will be updated
    self.current_user = user
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.hash(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Location Management methods:
  #These methods are designed to store a user's intended destination URL within their session,
  #and then forward along to that URL after authentication is completed. The `redirect_back_or` method
  # can be used in place of a normal `redirect_to` method in cases where the user was asked
  #to sign in before completing an action.
  def store_location
    if request.get?
      session[:return_to] = request.url
    end
  end
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

    # Security Checkpoint method:

  def require_signin
    unless signed_in?
      store_location
      flash[:notice] = "Please sign in."
      redirect_to signin_url
    end
  end

end


