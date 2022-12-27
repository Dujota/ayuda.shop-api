# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
             status: {
               code: 200,
               message: "Logged in sucessfully."
             },
             # data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
             data: resource
           },
           status: :ok
  end

  def logout_success
    render json: {
             status: 200,
             message: "logged out successfully"
           },
           status: :ok
  end

  def logout_failed
    render json: {
             status: 401,
             message: "Couldn't find an active session."
           },
           status: :unauthorized
  end

  def respond_to_on_destroy
    current_user ? logout_success : logout_failed
  end
end
