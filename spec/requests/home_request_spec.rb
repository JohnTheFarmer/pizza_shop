# spec/requests/home_request_spec.rb
require 'rails_helper'

RSpec.describe "HomeController", type: :request do
  describe "GET /" do
    it "renders the index page and displays a list of pizzas" do
      pizza = create(:pizza)

      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(pizza.name)  # Check if pizza name appears in the HTML
    end
  end
end
