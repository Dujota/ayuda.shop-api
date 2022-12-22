class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable,  and :omniauthable
  #:recoverable, #:rememberable, #:validatable, :trackable,
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
