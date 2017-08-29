class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    flash[:errors] = @comment.errors.full_messages
    redirect_to users_url
  end

  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end

end
