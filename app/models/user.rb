class User < ApplicationRecord
  ROLES = %w[customer chef owner].freeze

  # Validations
  validates :role, inclusion: { in: ROLES }

  # Devise Modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Callbacks
  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "customer"
  end
end
