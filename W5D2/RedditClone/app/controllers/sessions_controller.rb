class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
      )

    if @user
      redirect_to users_url
    else
      flash[:errors] = ['Invalid username or/and password']
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
