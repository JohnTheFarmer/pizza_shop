# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Seeding users with Devise and ensuring no duplicates
User.find_or_create_by!(email: 'owner@test.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.role = 'owner'
  end
  
  User.find_or_create_by!(email: 'chef@test.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.role = 'chef'
  end
  
  User.find_or_create_by!(email: 'customer@test.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.role = 'customer'
  end



# Create Toppings only if they do not exist
pepperoni = Topping.find_or_create_by!(name: 'Pepperoni') { |t| t.description = 'Delicious pepperoni slices' }
mushrooms = Topping.find_or_create_by!(name: 'Mushrooms') { |t| t.description = 'Fresh mushrooms' }
olives = Topping.find_or_create_by!(name: 'Olives') { |t| t.description = 'Black olives' }
bell_peppers = Topping.find_or_create_by!(name: 'Bell Peppers') { |t| t.description = 'Sweet bell peppers' }
onions = Topping.find_or_create_by!(name: 'Onions') { |t| t.description = 'Sliced onions' }
pineapple = Topping.find_or_create_by!(name: 'Pineapple') { |t| t.description = 'Sweet pineapple' }
bbq_chicken = Topping.find_or_create_by!(name: 'BBQ Chicken') { |t| t.description = 'Grilled BBQ chicken' }

# Create Pizzas only if they do not exist
margherita = Pizza.find_or_create_by!(name: 'Margherita') do |pizza|
  pizza.toppings << [pepperoni, mushrooms]  # Add toppings to Margherita
end

pepperoni_pizza = Pizza.find_or_create_by!(name: 'Pepperoni') do |pizza|
  pizza.toppings << pepperoni  # Add only pepperoni
end

vegetarian_pizza = Pizza.find_or_create_by!(name: 'Vegetarian') do |pizza|
  pizza.toppings << [bell_peppers, onions, olives, mushrooms]  # Multiple toppings for Vegetarian
end

hawaiian_pizza = Pizza.find_or_create_by!(name: 'Hawaiian') do |pizza|
  pizza.toppings << pineapple  # Only pineapple topping
end

bbq_chicken_pizza = Pizza.find_or_create_by!(name: 'BBQ Chicken') do |pizza|
  pizza.toppings << [bbq_chicken, onions]  # BBQ Chicken with BBQ Chicken and Onions
end

# Check if the data was added successfully
puts "Created #{Pizza.count} pizzas and #{Topping.count} toppings."

