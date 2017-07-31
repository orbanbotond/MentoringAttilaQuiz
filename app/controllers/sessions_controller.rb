class SessionsController < ApplicationController
  
  def index

  end

  def new

  end

  def create
    user = User.autenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to users_path
    else
      render "new"
    end
  end

end
