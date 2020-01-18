class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]
  before_action :require_login, except: :create

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
  def show
    @user = User.find(params[:id])
    render json: {user: @user}
  end



  # PATCH/PUT /users/1
  def update
    user = User.find(params[:id])
    if user.update_attributes(user_update_params)
    render json: {
        status: 200,
        user: user
    } 
  
    else 
      render json: {
        status: 500,
        errors: user.errors.full_messages
      }
    end
  end

  # DELETE /users/1
  def destroy
    user = User.find(params[:id])
    user.destroy
  end

  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
    end

    def user_update_params
      params.require(:user).permit(:username, :email, :admin)
    end

end
