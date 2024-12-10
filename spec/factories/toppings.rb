FactoryBot.define do
  factory :topping do
    name { Faker::Food.ingredient }

    trait :cheese do
      name { 'Cheese' }
    end

    trait :tomato do
      name { 'Tomato' }
    end

    trait :pepperoni do
      name { 'Pepperoni' }
    end

    trait :vegan do
      name { 'Vegan Cheese' }
    end
  end
end
