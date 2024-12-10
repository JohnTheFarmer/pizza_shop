require 'rails_helper'

RSpec.describe 'Managing Toppings', type: :system do
  let!(:owner) { create(:owner) }
  let!(:chef) { create(:chef) }
  let!(:customer) { create(:customer) }

  let!(:pepperoni) { create(:topping, :pepperoni) }
  let!(:tomato) { create(:topping, :tomato) }
  let!(:cheese) { create(:topping, :cheese) }

  def sign_in_as(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  def verify_success_message(action, entity_name)
    case action
    when 'create'
      expect(page).to have_content("#{entity_name} was successfully added.")
    when 'update'
      expect(page).to have_content("#{entity_name} was successfully updated.")
    when 'delete'
      expect(page).to have_content("#{entity_name} was successfully removed.")
    end
  end

  describe 'Listing Toppings' do
    it 'allows the owner to see a list of available toppings' do
      sign_in_as(owner)

      visit toppings_path

      expect(page).to have_content('Cheese')
      expect(page).to have_content('Pepperoni')
    end

    it 'does not allow the chef to see the toppings' do
      sign_in_as(chef)

      visit toppings_path
      expect(page).to have_content('You are not authorized to access this page.')
    end
  end

  describe 'Adding a new Topping' do
    it 'allows the owner to add a new topping' do
      sign_in_as(owner)

      visit toppings_path
      click_on 'New Topping'

      fill_in 'Name', with: 'Mushrooms'
      click_on 'Create Topping'

      verify_success_message('create', 'Mushrooms')
    end

    it 'does not allow duplicate toppings' do
      sign_in_as(owner)

      visit toppings_path
      click_on 'New Topping'

      fill_in 'Name', with: 'Cheese'
      click_on 'Create Topping'

      expect(page).to have_content('Failed to add topping. Topping name must be unique.')
    end
  end

  describe 'Editing a Topping' do
    it 'allows the owner to update an existing topping' do
      sign_in_as(owner)

      visit toppings_path
      click_on 'Edit', match: :first

      fill_in 'Name', with: 'Apple'
      click_on 'Update Topping'

      verify_success_message('update', 'Apple')
    end
  end

  describe 'Deleting a Topping' do
    it 'allows the owner to delete an existing topping' do
      sign_in_as(owner)

      visit toppings_path
      accept_confirm do
        click_on 'Delete', match: :first
      end

      verify_success_message('delete', 'Pepperoni')
      expect(page).not_to have_selector('li', text: 'Pepperoni')
    end
  end
end
