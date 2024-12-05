class HomeController < ApplicationController
    def index
      # Raw data for pizzas and toppings
      @pizzas = Pizza.all
    end
  end
  