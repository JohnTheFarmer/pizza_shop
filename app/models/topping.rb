class Topping < ApplicationRecord
    has_and_belongs_to_many :pizzas
    validates :name, presence: true, uniqueness: true
    validates :description, length: { maximum: 300 }
end
