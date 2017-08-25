class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user.nil?
      flash.now[:errors] = @user.errors.full_messages
      render :new
    else
      log_in_user!(@user)
      redirect_to :root
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).premit(:email, :password)
  end

end
