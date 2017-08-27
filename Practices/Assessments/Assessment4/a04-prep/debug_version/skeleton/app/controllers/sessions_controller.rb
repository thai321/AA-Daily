class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(
      params[:username],
      params[:password]
    )

    if user.nil?
      sign_in(user)
      redirect_to links_url
    else
      flash.now[:errors] = 'Invalid username or password'
      render :create
    end
  end

  def destroy
    redirect_to new_session_url
  end
end
