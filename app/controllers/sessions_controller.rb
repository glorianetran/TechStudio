class SessionsController < ApplicationController
  def create
  	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
  	session[:user_id] = @user.id
  	redirect_back_or_default("/")
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to "/"
  end

end