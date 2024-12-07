# spec/requests/toppings_request_spec.rb
require 'rails_helper'

RSpec.describe "Manage Toppings", type: :request do
  let!(:topping) { create(:topping) }
  let(:valid_params) { { topping: { name: "Test Topping", description: "Delicious" } } }
  let(:invalid_params) { { topping: { name: "", description: "" } } }
  let(:owner) { create(:owner) }

  before do
    sign_in owner
  end

  describe "GET /toppings" do
    it "renders the toppings index page" do
      get toppings_path
      expect(Topping.count).to eq(1) # Ensure the topping exists

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Toppings")
    end
  end

  describe "GET /toppings/new" do
    it "renders the new topping form" do
      get new_topping_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Topping")
    end
  end

  describe "POST /toppings" do
    context "with valid params" do
      it "creates a new topping and redirects to toppings path" do
        post toppings_path, params: valid_params
        expect(response).to redirect_to(toppings_path)
        follow_redirect!
        expect(response.body).to include("Test Topping")
      end
    end

    context "with invalid params" do
      it "renders the new topping form with error messages" do
        post toppings_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Topping Name")
      end
    end
  end

  describe "GET /toppings/:id/edit" do
    it "renders the edit topping form" do
      get edit_topping_path(topping)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Topping")
    end
  end

  describe "PATCH /toppings/:id" do
    context "with valid params" do
      it "updates the topping and redirects to toppings path" do
        patch topping_path(topping), params: { topping: { name: "Updated Topping" } }
        expect(response).to redirect_to(toppings_path)
        follow_redirect!
        expect(response.body).to include("Updated Topping")
      end
    end

    context "with invalid params" do
      it "renders the edit topping form with error messages" do
        patch topping_path(topping), params: { topping: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Topping Name")
      end
    end
  end

  describe "DELETE /toppings/:id" do
    it "deletes the topping and redirects to toppings path" do
      expect(Topping.count).to eq(1) # Ensure the topping exists
      expect {
        delete topping_path(topping)
      }.to change(Topping, :count).by(-1)

      expect(response).to redirect_to(toppings_path)
      follow_redirect!

      expect(response.body).to include("#{topping.name} was successfully removed.")
      body_without_flash = response.body.sub(/<div class="alert[^>]*>.*?<\/div>/m, '')

      expect(body_without_flash).not_to include(topping.name)
    end
  end
end
