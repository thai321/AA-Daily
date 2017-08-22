class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def index
    if params[:user_id]
      @comments = Comment.where(user_id: params[:user_id])
    elsif params[:artwork_id]
      @comments = Comment.where(artwork_id: params[:artwork_id])
    end

    @comments ||= Comment.all

    render json: @comments
  end

  def destroy
    @comment.destroy
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: 201
    else
      render json: @comment.errors.full_messages, status: 422
    end
  end

  private
  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :artwork_id)
  end

end
