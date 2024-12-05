class User < ApplicationRecord
  ROLES = %w[customer chef owner].freeze

  # Validations
  validates :role, inclusion: { in: ROLES }

  # Devise Modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
