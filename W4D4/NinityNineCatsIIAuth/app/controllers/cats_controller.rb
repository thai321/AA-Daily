class CatsController < ApplicationController
  before_action :set_cat, only: [:show]
  before_action :require_user!, only: [:new, :create, :update, :edit]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = current_user.cats.find(params[:id])
    render :edit
  end

  def update
    @cat = current_user.cats.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def check_owner
    # current_user = @cat.owner
    if !current_user
      redirect_to cats_url
    elsif !(current_user.id == @cat.owner.id)
      redirect_to user_url(current_user)
    end
  end

  def set_cat
    @cat = Cat.find(params[:id])
  end
end
