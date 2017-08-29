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
    @goal = Goal.find(params[:id])
    @comments = @goal.goal_comments
    render :show
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update_attributes(goal_params)
    flash[:errors] = @goal.errors.full_messages
    redirect_to current_user
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :user_id, :private, :completed)
  end
end
