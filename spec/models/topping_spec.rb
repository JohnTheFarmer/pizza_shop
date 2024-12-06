require 'rails_helper'

RSpec.describe Topping, type: :model do
  describe 'validations' do
    it 'is valid with a name and description' do
      topping = build(:topping)
      expect(topping).to be_valid
    end

    it 'is invalid without a name' do
      topping = build(:topping, name: nil)
      topping.valid?
      expect(topping.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate name' do
      create(:topping, :cheese)
      topping = build(:topping, :cheese)
      topping.valid?
      expect(topping.errors[:name]).to include('has already been taken')
    end

    it 'is invalid with a description longer than 50 characters' do
      topping = build(:topping, description: 'a' * 51)
      topping.valid?
      expect(topping.errors[:description]).to include('is too long (maximum is 50 characters)')
    end
  end

  describe 'associations' do
    it 'can have many pizzas through has_and_belongs_to_many' do
      pizza1 = create(:pizza, :margherita)
      pizza2 = create(:pizza, :pepperoni)

      topping = create(:topping, :cheese)

      pizza1.toppings << topping
      pizza2.toppings << topping

      expect(pizza1.toppings).to include(topping)
      expect(pizza2.toppings).to include(topping)

      # Verify that the same pizzas are associated with the topping
      expect(topping.pizzas).to include(pizza1, pizza2)
    end
  end
end
