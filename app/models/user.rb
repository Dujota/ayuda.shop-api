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
end
