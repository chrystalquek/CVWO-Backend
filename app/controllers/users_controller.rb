class UsersController < AuthController
  # before_action :set_user, only: [:show, :update, :destroy]
  before_action :require_admin, except: :create

    def create
      user = User.new(user_params)
      if user.save
          payload = {user_id: user.id}
          token = encode_token(payload)
          render json: {user: user, jwt: token}
      else
          render json: {errors: user.errors.full_messages}
      end
    end


  # GET /users
  def index
    @users = User.all

    render json: {users: @users}
  end

  # # GET /users/1
  # def show
  #   render json: @user
  # end



  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
   
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
    end
end
