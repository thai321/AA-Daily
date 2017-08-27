# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { |n| Faker::Internet.email }
    password { |p| Faker::Internet.password }

    factory :thai do
      email 'thai@example.com'
      password 'password'
    end
  end

end
