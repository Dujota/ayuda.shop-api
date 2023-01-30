module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if env["warden"].user
        env["warden"].user
      elsif request.params[:token] || request.headers[:HTTP_AUTHORIZATION]
        find_verified_user_from_jwt
      else
        reject_unauthorized_connection
      end
    end

    # def authenticate_user
    #   user = find_verified_user_from_jwt
    #   user ? user : reject_unauthorized_connection
    # end

    def find_verified_user_from_jwt
      if request.params[:token]
        decoded_token =
          JWT.decode(request.params["token"], ENV["DEVISE_JWT_SECRET_KEY"])
      elsif request.headers[:HTTP_AUTHORIZATION]
        decoded_token =
          JWT.decode(
            request.headers[:HTTP_AUTHORIZATION].split(" ").last,
            ENV["DEVISE_JWT_SECRET_KEY"]
          )
      else
        return nil
      end

      user_id = decoded_token[0]["sub"]
      jti = decoded_token[0]["jti"]
      verified_user = User.find_by(id: user_id)

      if verified_user.jti == jti
        verified_user
      else
        return nil
      end
    end
  end
end
