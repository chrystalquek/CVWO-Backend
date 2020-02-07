class AuthController < ApplicationController
    before_action :require_login, except: :login

    # returns boolean
    def logged_in?
        !!session_user
    end
    
    # catches unauthorized api calls
    def require_login
        render json: {message: 'Pleae login'}, status: :unauthorized unless logged_in?
    end

    # gives user token upon logging in, subsequently stored in localStorage
    def login
        user = User.find_by(username: auth_params[:username])
        if user && user.authenticate(auth_params[:password])
            payload = {user_id: user.id}
            token = encode_token(payload)
            render json: {jwt: token, userid: user.id, admin: user.admin}
        else
            render json: {failure: "login failed"}
        end
    end

    def auto_login
        if session_user
            render json: session_user
        else
            render json: {errors: "No User Logged In"}
        end
    end


    private
    def auth_params
        params.require(:user).permit(:username, :email, :password, :admin)
    end

end