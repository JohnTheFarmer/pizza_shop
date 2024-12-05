require 'rails_helper'

RSpec.describe Pizza, type: :model do
  it "is valid with a name" do
    pizza = Pizza.new(name: "Margherita")
    expect(pizza).to be_valid
  end

  it "is invalid without a name" do
    pizza = Pizza.new(name: nil)
    expect(pizza).to_not be_valid
  end
end
