module SessionsHelper

  # Logs in the given user.
  def login(user)
    session[:is_logged_in] = true
    session[:user_id] = user.id
    session[:email] = user.email
    session[:full_name] = user.full_name
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def is_logged_in?
    !current_user.nil?
  end

  def logout
    @current_user = nil
    session.clear
  end
end