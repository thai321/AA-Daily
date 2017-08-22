class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    # Search by user name
    if params[:query]
      @users = User.where("username LIKE '%#{params[:query]}%'")
    else
      @users = User.all
    end

    if params[:query] && @users.empty?
      render plain: "Can't find the user with #{params[:query]}", status: 404
    else
      render json: @users, status: 200
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    if @user
      render json: @user
    else
      render plain: "Can't find the user with id: #{params[:id]}", status: 404
    end
  end

  def update

    if @user.nil?
      render plain: "Can't find the user with id: #{params[:id]}", status: 404
    elsif @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def destroy
    @user.destroy
    render json: @user
  end


  private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
