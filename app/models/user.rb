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
end
