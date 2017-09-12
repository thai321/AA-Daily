class StaticPagesController < ApplicationController
  def root
    # render json: Todo.all
    render :root
  end
end
