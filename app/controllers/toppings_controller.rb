class ToppingsController < ApplicationController
  before_action :set_topping, only: %i[show edit update destroy]

  def show
  end
  
  def index
    @toppings = Topping.all
  end

  def new
    @topping = Topping.new
  end

  def create
    @topping = Topping.new(topping_params)
    if @topping.save
      redirect_to toppings_path, notice: 'Topping was successfully added.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @topping.update(topping_params)
      redirect_to toppings_path, notice: 'Topping was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topping.destroy
    redirect_to toppings_path , notice: 'Topping was successfully destroyed.'
  end

  private

    def set_topping
      @topping = Topping.find(params[:id])
    end

    def topping_params
      params.require(:topping).permit(:name, :description)
    end
end
