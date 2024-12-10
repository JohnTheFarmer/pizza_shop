require 'rails_helper'

RSpec.describe 'Managing Pizzas as a Chef', type: :system do
  let!(:chef) { create(:chef) }
  let!(:pepperoniPizza) { create(:pizza, :pepperoni) }
  let!(:tomatoPizza) { create(:pizza, :tomato) }
  let!(:cheesePizza) { create(:pizza, :cheese) }

  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  def verify_success_message(action, entity)
    expect(page).to have_content("#{entity} #{action} successfully.")
  end

  describe 'Listing Pizzas' do
    it 'allows the chef to see a list of available pizzas' do
      sign_in_as(chef)

      visit pizzas_path

      expect(page).to have_content('Pepperoni')
      expect(page).to have_content('Tomato')
      expect(page).to have_content('Cheese')
    end

    it 'does not allow the chef to access toppings page' do
      sign_in_as(chef)

      visit toppings_path

      expect(page).to have_content('You are not authorized to access this page.')
    end
  end

  describe 'Adding a Pizza' do
    it 'allows the chef to create a new pizza and add toppings' do
      sign_in_as(chef)

      visit pizzas_path
      click_on 'New Pizza'

      fill_in 'Name', with: 'Hawaiian'
      check 'Cheese'
      check 'Tomato'
      click_on 'Create Pizza'

      expect(page).to have_content('Hawaiian')
      verify_success_message('created', 'Hawaiian pizza')
      expect(page).to have_content('Cheese')
      expect(page).to have_content('Tomato')
    end

    it 'does not allow the chef to create a duplicate pizza' do
      sign_in_as(chef)

      visit pizzas_path
      click_on 'New Pizza'

      fill_in 'Name', with: 'Pepperoni'
      check 'Cheese'
      click_on 'Create Pizza'

      expect(page).to have_content('Failed to add topping. Topping name must be unique.')
    end
  end

  describe 'Editing a Pizza' do
    it 'allows the chef to update an existing pizza' do
      sign_in_as(chef)

      visit pizzas_path
      click_on 'Edit', match: :first

      fill_in 'Name', with: 'Veggie Supreme'
      click_on 'Update Pizza'

      expect(page).to have_content('Veggie Supreme')
      verify_success_message('updated', 'Veggie Supreme pizza')
    end
  end

  describe 'Deleting a Pizza' do
    it 'allows the chef to delete an existing pizza' do
      sign_in_as(chef)

      visit pizzas_path

      accept_confirm do
        click_on 'Delete', match: :first
      end

      verify_success_message('deleted', 'Pepperoni pizza')
      expect(page).not_to have_selector('li', text: 'Pepperoni')
    end
  end

  describe 'Updating toppings on a pizza' do
    it 'allows the chef to update toppings on an existing pizza' do
      sign_in_as(chef)

      visit pizzas_path
      click_on 'Edit', match: :first

      uncheck 'Pepperoni'
      check 'Tomato'
      click_on 'Update Pizza'

      expect(page).to have_content('Tomato')
      expect(page).not_to have_selector('li', text: 'Pepperoni')
      verify_success_message('updated', 'Pepperoni pizza')
    end
  end
end
