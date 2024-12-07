FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
  end

  factory :customer, parent: :user do
    role { 'customer' }
  end

  factory :owner, parent: :user do
    role { 'owner' }
  end

  factory :chef, parent: :user do
    role { 'chef' }
  end
end
