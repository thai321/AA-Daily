class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:notices] = ['Comment saved!']
    else
      flash[:errors] = @comment.errors.full_messages
    end

    redirect_to users_url
  end

  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end

end
