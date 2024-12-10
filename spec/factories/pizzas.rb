FactoryBot.define do
  factory :pizza do
    name { "Default Pizza" }
    toppings { [] }


    trait :margherita do
      name { "Margherita" }
      toppings { [ create(:topping, :tomato) ] }
    end

    trait :pepperoni do
      name { "Pepperoni" }
      toppings { [ create(:topping, :pepperoni) ] }
    end

    trait :tomato do
      name { "Tomato" }
      toppings { [ create(:topping, :tomato) ] }
    end

    trait :cheese do
      name { "Cheese" }
      toppings { [ create(:topping, :cheese) ] }
    end
  end
end
