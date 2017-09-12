class Api::TodosController < ApplicationController
  def show
    render json: Todo.find(params[:id])
  end

  def index
    render json: Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(todo_params)
      render json: @todo
    else
      render json: @todo.errors.full_messages
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    render :index
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end
end


=begin
@todo ={

id:
title:
body:
done:
}

let data = {todo:
            {
              title: 'cat2',
              body: 'Kity'
            }
          }

$.ajax({
  type: "POST",
  url: url,
  data: data,
}).then(todo => console.log(todo));


=end
