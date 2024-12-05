class ToppingsController < ApplicationController
  before_action :set_topping, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_owner, only: [:index]

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
      redirect_to toppings_path, notice: "#{@topping.name} was successfully added."
    else
      if @topping.errors[:name].any?
        flash[:alert] = 'Failed to add topping. Topping name must be unique.'
      else
        flash[:alert] = 'Failed to add topping. Please check your input.'
      end
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit
  end

  def update
    if @topping.update(topping_params)
      redirect_to toppings_path, notice: "#{@topping.name} was successfully updated."
    else
      flash[:alert] = 'Failed to update topping. Please fix the errors below.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @topping.destroy
      redirect_to toppings_path, notice: "#{@topping.name} was successfully removed."
    else
      redirect_to toppings_path, alert: 'Failed to delete topping. Please try again later.'
    end
  end

  private

    def authorize_owner
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.role == "owner"
    end
    
    def set_topping
      @topping = Topping.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to toppings_path, alert: 'Topping not found.'
    end

    def topping_params
      params.require(:topping).permit(:name, :description)
    end
end
