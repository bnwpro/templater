class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to user_campaigns_path(user.id), :notice => "Logged in as #{user.name}"
      #redirect_to users_path, :notice => "Logged in as Admin!"
    else
      flash[:notice] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    @_current_user = session[:current_user_id] = nil
    redirect_to login_path, :notice => "Logged out!"
  end
  
end
