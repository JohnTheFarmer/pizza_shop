class PizzasController < ApplicationController
    before_action :set_pizza, only: %i[show edit update destroy add_topping remove_topping]
    before_action :set_topping, only: %i[add_topping remove_topping]
    before_action :authenticate_user!
    before_action :authorize_owner_or_chef, only: [ :index ]


    def index
      @pizzas = Pizza.all
    end

    def show
    end

    def new
      @pizza = Pizza.new
      @toppings = Topping.all
    end

    def create
      @pizza = Pizza.new(pizza_params)

      # Assign toppings to pizza
      topping_ids = params[:pizza][:topping_ids].reject(&:blank?) # Clean empty values
      @pizza.toppings = Topping.find(topping_ids) if topping_ids.any?

      if @pizza.save
        redirect_to pizzas_path, notice: "Pizza created successfully."
      else
        @toppings = Topping.all
        if @pizza.errors[:name].any?
          flash[:alert] = "Failed to add topping. Topping name must be unique."
        else
          flash[:alert] = "Failed to add topping. Please check your input."
        end
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @toppings = Topping.all
    end

    def update
      topping_ids = params[:pizza][:topping_ids].reject(&:blank?) # Clean empty values
      @pizza.toppings = Topping.find(topping_ids) if topping_ids.any?

      if @pizza.update(pizza_params)
        redirect_to pizzas_path, notice: "Pizza updated successfully."
      else
        @toppings = Topping.all
        if @pizza.errors[:name].any?
          flash[:alert] = "Failed to add topping. Topping name must be unique."
        else
          flash[:alert] = "Failed to add topping. Please check your input."
        end
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @pizza.destroy
      redirect_to pizzas_url, notice: "Pizza deleted successfully."
    end

    def add_topping
      @pizza.toppings << @topping unless @pizza.toppings.include?(@topping)
      redirect_to @pizza, notice: "Topping added to pizza."
    end

    def remove_topping
      @pizza.toppings.delete(@topping)
      redirect_to @pizza, notice: "Topping removed from pizza."
    end

    private

    def authorize_owner_or_chef
      unless current_user.role.in?(%w[owner chef])
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end

    def set_pizza
      @pizza = Pizza.find(params[:id])
    end

    def set_topping
      @topping = Topping.find(params[:topping_id])
    end

    def pizza_params
      params.require(:pizza).permit(:name)
    end
end
