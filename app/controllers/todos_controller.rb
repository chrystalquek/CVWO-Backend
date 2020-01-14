# class TodosController < ApplicationController
class TodosController < AuthController
  before_action :require_login
  

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = params[:user_id]
  
    if @todo.save
      render json: {
        status: :created,
        todoid: @todo.id
      }
    else 
      render json: {
        status: 500,
        errors: @todo.errors.full_messages
      }
    end
end


def destroy
    todo = Todo.find(params[:id])
    todo.destroy
end

def index
   
    @todos = Todo.all.where("user_id IN(?)", params[:user_id])
    # Todo.find(:all, :user_id => params[:user_id])
    
      render json: {
        todos: @todos
      }

end

def show
     render json: {
      todo: @todo
    }
 end

def update
    todo = Todo.find(params[:id])
    if todo.update_attributes(todo_params)
    render json: {
        status: 200,
        todo: todo
    } 
  
    else 
      render json: {
        status: 500,
        errors: todo.errors.full_messages
      }
    end
end

  private
   
    def todo_params
      params.require(:todo).permit(:title, :description, :tag, :category, :duedate, :user_id)
    end
end
