class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    # byebug
    if comment_params[:parent_id]
      post_id = Comment.find(comment_params[:parent_id]).post_id
      @comment.parent_id = comment_params[:parent_id]
      @comment.post_id = post_id
    end
    if @comment.save
      redirect_to @comment.post
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment_url(@comment.post_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
  end
end
