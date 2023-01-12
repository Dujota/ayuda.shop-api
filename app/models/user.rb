class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,  and :omniauthable
  #:recoverable, #:rememberable, #:validatable,
  devise :database_authenticatable,
         :registerable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :services, dependent: :destroy
  has_many :listings, dependent: :destroy

  # Authorization
  # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/role_based_authorization.md#many-roles-per-user
  # https://github.com/martinrehfeld/role_model
  include RoleModel
  roles_attribute :roles_mask
  roles :admin, :content_editor, :guest

  # GENERATE REFRESH TOKEN
  def create_new_jwt_token(scope = "user")
    # First revoke the existing token, by changing the jti value
    update(jti: SecureRandom.uuid)

    payload = {
      sub: id,
      exp: expiration_time,
      iat: Time.now.to_i,
      jti: jti,
      aud: nil,
      scp: scope || "user"
    }

    JWT.encode(payload, ENV["DEVISE_JWT_SECRET_KEY"], "HS256")
  end

  private

  def expiration_time
    # can set here a time in the future depending on needs
    Time.now.to_i + 60.minutes
  end
end
