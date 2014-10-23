module SessionsHelper
  def current_user
    remember_token = User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user?(user)
    current_user == user
  end

  def sign_out
    current_user.update_attribute(:remember_token)
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  #location management methods
  def store_location
    if request.get?
      session[:return_to] = request_url
    end
  end

  # redirect the user back to where they were before they logged in
  def redirect_back_or(default)
    reditect_to(sessions[:return_to] || default)
    sessions.delete(:return_to)
  end

  def require_signin
    if !signed_in?
      store_location
      flash[:notice] = "Please sign in"
      redirect_to signin_url
    end
  end

end
