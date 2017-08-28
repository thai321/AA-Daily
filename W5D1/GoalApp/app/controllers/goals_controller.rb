class GoalsController < ApplicationController
  before_action :require_login!

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to current_user
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to current_user
  end

  def show
  end

  def edit
    @goal = current_user.goals.find(params[:id])
    render :edit
  end

  def update
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :user_id, :private, :completed)
  end
end
