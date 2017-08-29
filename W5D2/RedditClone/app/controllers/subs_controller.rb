class SubsController < ApplicationController
  before_action :require_login!, only: [:new, :create, :edit, :update]
  before_action :require_login_as_owner!, only: [:edit, :update]
  before_action :set_sub, only: [:show, :edit, :update]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def set_sub
    @sub = Sub.find(params[:id])
  end

  def require_login_as_owner!
    redirect_to sub_url(params[:id]) if !current_user.subs.find(params[:id])
  end
end
