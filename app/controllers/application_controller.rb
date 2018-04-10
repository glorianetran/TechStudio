class ApplicationController < ActionController::Base
 protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	rescue ActiveRecord::RecordNotFound
  end
  
  def store_return_to
    session[:return_to] = request.url
  end

  def user_signed_in?
  	# converts current_user to a boolean by negating the negation
  	!!current_user
  end
   
end
