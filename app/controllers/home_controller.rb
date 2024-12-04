class HomeController < ApplicationController
    def index
      # Raw data for pizzas and toppings
      @pizzas = [
        {
          name: 'Pepperoni',
          description: 'Classic pizza with pepperoni',
          toppings: ['Pepperoni', 'Onions']
        },
        {
          name: 'Veggie',
          description: 'A healthy choice with mushrooms, onions, and green peppers',
          toppings: ['Mushrooms', 'Onions', 'Green Peppers']
        },
        {
          name: 'Margarita',
          description: 'Simple yet delicious with mozzarella and fresh basil',
          toppings: []
        },
        {
          name: 'Deluxe',
          description: 'Loaded with pepperoni, mushrooms, onions, and green peppers',
          toppings: ['Pepperoni', 'Mushrooms', 'Onions', 'Green Peppers']
        }
      ]
    end
  end
  