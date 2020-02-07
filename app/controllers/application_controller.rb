class ApplicationController < ActionController::API

    # method to encode user details using JWT
    def encode_token(payload)
        JWT.encode(payload, 'my_secret')
    end

    # check if user is valid by checking user_id with database
    def session_user
        decoded_hash = decoded_token
        if decoded_hash && !decoded_hash.empty?
            user_id = decoded_hash[0]['user_id']
            @user = User.find_by(id: user_id)
        else
            nil
        end
    end

    def require_admin
        render json: {message: 'Access denied, not admin'}, status: :unauthorized unless is_admin?
    end


    def is_admin?
        !!admin_user
    end

    def admin_user
        decoded_hash = decoded_token
        if decoded_hash && !decoded_hash.empty?
            user_id = decoded_hash[0]['user_id']
            @is_admin = User.find_by(id: user_id).admin 
        else
            nil
        end
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                []
            end
        end
    end
  
end
