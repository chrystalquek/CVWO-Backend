class TodosController < AuthController
  # ensure that user is login before any action on todo is executed
  before_action :require_login

  # add new todo, accessed using axios.post
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

# delete todo, accessed using axios.delete
def destroy
    todo = Todo.find(params[:id])
    todo.destroy
end

# show all todos, accessed using axios.get
def index
    @todos = Todo.all.where("user_id IN(?)", params[:user_id])
    render json: {
      todos: @todos
    }
end

# show only 1 todo, required for rendering fields before update
def show
  todo = Todo.find(params[:id])
     render json: {
      todo: todo
    }
end

# update a todo, accessed using axios.put
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
