class TodosController < ApplicationController
  #before_action :set_todo, only: [:show, :update, :destroy]

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = params[:user_id]
  
    if @todo.save
      render json: {
        status: :created,
        todos: @todo.user
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
    # @user = @todo.user
    # @todos = @user.todos
    # @todos = Todo.find(params[:user_id])
    @todos = Todo.all.where("user_id IN(?)", params[:user_id])
    # Todo.find(:all, :user_id => params[:user_id])
    # @todos = Todo.all
    # if @todos
      render json: {
        todos: @todos
      }
    # else
    #   render json: {
    #     status: 500,
    #     errors: ['no todos found']
    #   }
end

def update
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_params)
    render json: {
        status: 200,
        todo: todo
    }
end
  


  # GET /todos
  # def index
  #   @todos = Todo.all

  #   render json: @todos
  # end

  # # GET /todos/1
  # def show
  #   render json: @todo
  # end

  # POST /todos
  # def create
  #   @todo = Todo.new(todo_params)

  #   if @todo.save
  #     render json: @todo, status: :created, location: @todo
  #   else
  #     render json: @todo.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /todos/1
  # def update
  #   if @todo.update(todo_params)
  #     render json: @todo
  #   else
  #     render json: @todo.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /todos/1
  # def destroy
  #   @todo.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_todo
    #   @todo = Todo.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def todo_params
      params.require(:todo).permit(:title, :description, :tag, :category, :duedate, :user_id)
    end
end
