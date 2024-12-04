class Topping < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :description, length: { maximum: 300 }
end
  