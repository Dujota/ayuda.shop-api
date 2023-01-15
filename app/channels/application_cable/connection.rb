module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      debugger
      if verified_user = env["warden"].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def authenticate_user
      user = find_verified_user_from_jwt

      user ? user : reject_unauthorized_connection
    end

    def find_verified_user_from_jwt
      auth_token = request.headers[:HTTP_AUTHORIZATION].split(" ").last
      decoded_token = JWT.decode(auth_token, nil, false)
      user_id = decoded_token[0]["sub"]
      User.find_by(id: user_id)
    end
  end
end
