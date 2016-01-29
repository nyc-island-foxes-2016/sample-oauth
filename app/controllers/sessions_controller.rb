class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if (user && user.authenticate(params[:password]))
      session[:user_id]
      flash[:notice] = 'Login successful'
      redirect_to '/'
    end
  end
end