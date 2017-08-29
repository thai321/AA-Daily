class PostsController < ApplicationController
  before_action :require_login!
  before_action :require_login_as_owner!, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to current_user
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_login_as_owner!
    redirect_to Post.find(params[:id]) if current_user.posts.find(params[:id])
  end
end
