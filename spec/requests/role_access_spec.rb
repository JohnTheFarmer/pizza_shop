require 'rails_helper'

RSpec.describe "Roles", type: :request do
  let(:pizza) { create(:pizza) }
  let(:topping) { create(:topping) }
  let(:valid_params) { { pizza: { name: "Test Pizza", topping_ids: [ topping.id ] } } }
  let(:invalid_params) { { pizza: { name: "", topping_ids: [] } } }

  describe "As an Owner" do
    before do
      @owner = create(:owner)
      sign_in @owner
    end

    context "Managing Pizzas" do
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
        it "creates a new pizza" do
          post pizzas_path, params: valid_params
          expect(response).to redirect_to(pizzas_path)
          follow_redirect!
          expect(response.body).to include("Test Pizza")
        end
      end
    end

    context "Managing Toppings" do
      describe "GET /toppings" do
        it "renders the toppings index page" do
          get toppings_path
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
    end
  end

  describe "As a Chef" do
    before do
      @chef = create(:chef) # Create a chef
      sign_in @chef # Sign in as a chef
    end

    context "Managing Pizzas" do
      describe "GET /pizzas" do
        it "renders the pizzas index page" do
          get pizzas_path
          expect(response).to have_http_status(:ok)
          expect(response.body).to include("Pizzas")
        end
      end
    end

    context "Managing Toppings" do
      describe "GET /toppings" do
        it "redirects to root path with access denied message" do
          get toppings_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end

      describe "GET /toppings/new" do
        it "redirects to root path with access denied message" do
          get new_topping_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end
    end
  end

  describe "As a Customer" do
    before do
      @customer = create(:customer) # Create a customer
      sign_in @customer # Sign in as a customer
    end

    context "Managing Pizzas" do
      describe "GET /pizzas" do
        it "redirects to root path with access denied message" do
          get pizzas_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end

      describe "GET /pizzas/new" do
        it "redirects to root path with access denied message" do
          get new_pizza_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end
    end

    context "Managing Toppings" do
      describe "GET /toppings" do
        it "redirects to root path with access denied message" do
          get toppings_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end

      describe "GET /toppings/new" do
        it "redirects to root path with access denied message" do
          get new_topping_path
          expect(response).to redirect_to(root_path)
          follow_redirect!
          expect(response.body).to include("You are not authorized to access this page.")
        end
      end
    end
  end

  describe "As a Non-logged-in User" do
    before do
      sign_out :user # Ensure no user is signed in
    end

    context "Managing Pizzas" do
      describe "GET /pizzas" do
        it "redirects to the sign-in page" do
          get pizzas_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe "GET /pizzas/new" do
        it "redirects to the sign-in page" do
          get new_pizza_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context "Managing Toppings" do
      describe "GET /toppings" do
        it "redirects to the sign-in page" do
          get toppings_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe "GET /toppings/new" do
        it "redirects to the sign-in page" do
          get new_topping_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
