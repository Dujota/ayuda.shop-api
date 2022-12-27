# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  protected

  def sign_up(resource_name, resource)
    #by pass the session store on the default implementation
    sign_in resource, store: false
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
               status: {
                 code: 200,
                 message: "Signed up sucessfully."
               },
               data: resource
               # data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
             }
    else
      render json: {
               status: {
                 message:
                   "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"
               }
             },
             status: :unprocessable_entity
    end
  end
end
