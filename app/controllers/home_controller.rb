class HomeController < ApplicationController
    def index
      @pizzas = Pizza.all
    end
end
