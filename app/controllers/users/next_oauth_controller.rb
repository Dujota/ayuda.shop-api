class Users::NextOAuthController < ApplicationController
  before_action :set_service
  before_action :set_user

  attr_reader :service, :user

  def oauth
    handle_auth params[:auth][:provider]
  end

  def verify_user
    if @user.present?
      sign_in @user, store: false
      verify_user_success
    else
      verify_user_failed
    end
  end

  private

  def handle_auth(kind)
    if service.present? #if the service exists
      service.update(service_attributes) # update the credentials to the newest ones on every log in
    else
      # create the service associated with the user from the oauth hash, we pull the data from the oauth response hash that we printed to the console
      user.services.create(service_attributes)
    end

    # TODO: setup the custom reg logic
    if user_signed_in?
      #   flash[:notice] = "Your #{kind} is now Connected"
      #   redirect_to edit_user_registration_path
    else
      # sign_in_and_redirect user, event: :authentication
      # set_flash_message :notice, :success, kind: kind
      # sign_in @user, store: false
    end
  end

  def verify_user_success
    render json: {
             status: 200,
             message: "verified user successfully"
           },
           status: :ok
  end

  def verify_user_failed
    render json: { status: 400 }, status: :bad_request
  end

  def set_service
    # look up the service in the db with the before action
    @service =
      Service.where(
        provider: params[:auth][:provider],
        uid: params[:auth][:uid]
      ).first
  end

  def set_user
    if user_signed_in?
      @user = current_user
    elsif service.present?
      @user = service.user
    elsif User.where(email: params[:auth][:info][:email]).any?
      # 5. user is logged out and they log in to a new account that doesnt match their old one, we throw exception to let them know

      # TODO: custom logic needed for returning or dupe users from oauth
    else
      # if doesnt exist, create the user,
      @user = create_user
    end
  end

  def expires_at
    if params[:auth][:credentials][:expires_at].present?
      Time.at(params[:auth][:credentials][:expires_at])
    else
      nil
    end
  end

  def service_attributes
    {
      provider: params[:auth][:provider],
      uid: params[:auth][:uid],
      access_token: params[:auth][:credentials][:access_token],
      email_verified: params[:auth][:email_verified],
      image: params[:auth][:info][:image],
      expires_at: expires_at #convert expiration date to a timestamp
    }
  end

  def create_user
    User.create(
      email: params[:auth][:info][:email],
      name: params[:auth][:info][:name],
      family_name: params[:auth][:info][:family_name],
      given_name: params[:auth][:info][:given_name],
      locale: params[:auth][:info][:locale],
      password: Devise.friendly_token[0, 20]
    )
  end
end
