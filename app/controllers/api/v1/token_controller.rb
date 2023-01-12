class API::V1::TokenController < ApplicationController
  before_action :authenticate_user!

  def refresh
    token = current_user.create_new_jwt_token
    render json: { token: token }, status: :ok
  end
end
