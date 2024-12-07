require 'rails_helper'

RSpec.describe "Manage Pizzas", type: :request do
  let(:pizza) { create(:pizza) }
  let(:topping) { create(:topping) }
  let(:valid_params) { { pizza: { name: "Test Pizza", topping_ids: [ topping.id ] } } }
  let(:invalid_params) { { pizza: { name: "", topping_ids: [] } } }
  let(:owner) { create(:owner) }

  before do
    sign_in owner
  end

  describe "GET /pizzas" do
    it "renders the pizzas index page" do
      get pizzas_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Pizzas")
    end
  end

  describe "GET /pizzas/new" do
    it "renders the new pizza form" do
      get new_pizza_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Pizza")
    end
  end

  describe "POST /pizzas" do
    context "with valid params" do
      it "creates a new pizza and redirects to pizzas path" do
        post pizzas_path, params: valid_params
        expect(response).to redirect_to(pizzas_path)
        follow_redirect!
        expect(response.body).to include("Test Pizza")
      end
    end

    context "with invalid params" do
      it "renders the new pizza form with error messages" do
        post pizzas_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Pizza Name")
      end
    end
  end

  describe "GET /pizzas/:id/edit" do
    it "renders the edit pizza form" do
      get edit_pizza_path(pizza)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Pizza")
    end
  end

  describe "PATCH /pizzas/:id" do
    context "with valid params" do
      it "updates the pizza and redirects to pizzas path" do
        patch pizza_path(pizza), params: { pizza: { name: "Updated Pizza" } }
        expect(response).to redirect_to(pizzas_path)
        follow_redirect!
        expect(response.body).to include("Updated Pizza")
      end
    end

    context "with invalid params" do
      it "renders the edit pizza form with error messages" do
        patch pizza_path(pizza), params: { pizza: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Pizza Name")
      end
    end
  end

  describe "DELETE /pizzas/:id" do
    it "deletes the pizza and redirects to pizzas path" do
      delete pizza_path(pizza)
      expect(response).to redirect_to(pizzas_path)
      follow_redirect!
      expect(response.body).not_to include(pizza.name)
    end
  end
end
