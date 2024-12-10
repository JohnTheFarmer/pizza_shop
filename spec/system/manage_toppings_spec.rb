# spec/system/manage_toppings_spec.rb
require 'rails_helper'

RSpec.describe "Manage Toppings", type: :system do
  let!(:owner) { FactoryBot.create(:user, email: "owner@test.com", password: "password", role: "owner") }

  before(:all) do
    @topping1 = Topping.create(name: "Pepperoni")
    @topping2 = Topping.create(name: "Mushrooms")
    visit new_user_session_path

    fill_in "Email", with: "owner@test.com"
    fill_in "Password", with: "password"
    click_button "Log in"
  end

  it "allows the owner to view a list of available toppings" do
    visit toppings_path

    expect(page).to have_text("Pepperoni")
    expect(page).to have_text("Mushrooms")
  end

  it "allows the owner to add a new topping" do
    visit new_topping_path
    fill_in "Name", with: "Olives"
    click_button "Create Topping"
    expect(page).to have_text("Olives")
  end

  it "prevents adding a duplicate topping" do
    visit new_topping_path
    fill_in "Name", with: "Pepperoni"
    click_button "Create Topping"
    expect(page).to have_text("Topping has already been taken")
  end

  it "allows the owner to delete an existing topping" do
    visit toppings_path
    within("li", text: @topping1.name) do
      click_link "Delete"
    end
    expect(page).not_to have_text(@topping1.name)
  end

  it "allows the owner to update an existing topping" do
    visit edit_topping_path(@topping1)
    fill_in "Name", with: "Apple"
    click_button "Update Topping"
    expect(page).to have_text("Extra Pepperoni")
    expect(page).not_to have_text("Pepperoni")
  end
end
