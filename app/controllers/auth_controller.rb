class AuthController < ApplicationController
    before_action :require_login, except: :login

    def logged_in?
        !!session_user
    end

    def require_login
        render json: {message: 'Pleae login'}, status: :unauthorized unless logged_in?
    end
    
    def login
        user = User.find_by(username: auth_params[:username])
        if user && user.authenticate(auth_params[:password])
            payload = {user_id: user.id}
            token = encode_token(payload)
            render json: {jwt: token, userid: user.id}
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
        params.require(:user).permit(:username, :email, :password)
    end

end