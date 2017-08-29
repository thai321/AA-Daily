class GoalCommentsController < ApplicationController

  def create
    @comment = GoalComment.new(goal_comment_params)
    @comment.user_id = current_user.id
    goal = Goal.find(params[:goal_id])
    @comment.target_id = goal.user_id
    @comment.goal_id = goal.id
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to goal
  end


  def goal_comment_params
    params.require(:goal_comment).permit(:content, :user_id, :target_id, :goal_id)
  end
end
