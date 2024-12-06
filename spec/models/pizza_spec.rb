require 'rails_helper'

RSpec.describe Pizza, type: :model do
  describe 'validations' do
    it 'is valid with a name and toppings' do
      pizza = Pizza.new(name: 'Margherita')
      topping1 = create(:topping, :cheese)
      topping2 = create(:topping, :tomato)

      pizza.toppings << topping1
      pizza.toppings << topping2

      expect(pizza).to be_valid
    end

    it 'is invalid without a name' do
      pizza = Pizza.new(name: nil)
      expect(pizza).not_to be_valid
      expect(pizza.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate name' do
      Pizza.create!(name: 'Margherita')

      pizza = Pizza.new(name: 'Margherita')
      expect(pizza).not_to be_valid
      expect(pizza.errors[:name]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'can have many toppings' do
      pizza = Pizza.create!(name: 'Margherita')
      topping1 = create(:topping, :cheese)
      topping2 = create(:topping, :tomato)
      topping3 = create(:topping, :vegan)


      pizza.toppings << topping1
      pizza.toppings << topping2
      pizza.toppings << topping3

      expect(pizza.toppings.count).to eq(3)
      expect(pizza.toppings).to include(topping1, topping2, topping3)
    end
  end
end
