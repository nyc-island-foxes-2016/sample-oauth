class SessionsController < ApplicationController

  def new
  end

  def create  # our own login
    user = User.find_by(email: params[:email], provider: 'SELF')
    if (user && user.authenticate(params[:password]))
      session[:user_id]
      flash[:notice] = 'Login successful'
      redirect_to '/'
    end
  end

  def oauth_create
    u = User.create_or_get_from_oauth(request.env['omniauth.auth'])
    if u
      flash[:notice] = 'Login successful'
      redirect_to '/'
    end
  end
end