# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  respond_to :json
  # def create
  #   self.resource =
  #     warden.authenticate!(auth_options.merge(store: !request.format.json?))
  #   super
  # end

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
