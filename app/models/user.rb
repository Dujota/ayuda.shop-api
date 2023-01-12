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
  def create_new_jwt_token
    update(jti: SecureRandom.uuid)
    JWT.encode(
      { sub: id, exp: expiration_time, iat: Time.now.to_i, jti: jti },
      Devise.secret_key
    )
  end

  private

  def expiration_time
    # can set here a time in the future depending on needs
    Time.now.to_i + 30.minutes
  end
end
