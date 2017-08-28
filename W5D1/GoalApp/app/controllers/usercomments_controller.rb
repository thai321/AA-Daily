class UsercommentsController < ApplicationController
  def new
    @comment = UserComment.new
    render :new
  end

  def create
    @comment = UserComment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.target_id = params[:user_id]

    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to user_url(params[:user_id])
  end

  private
  def comment_params
    params.require(:user_comment).permit(:content, :user_id, :target_id)
  end
end
