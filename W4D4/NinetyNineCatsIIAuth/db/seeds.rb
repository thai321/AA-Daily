# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

COLORS = %w(black white orange brown).freeze

User.destroy_all
Cat.destroy_all
CatRentalRequest.destroy_all

user1 = User.new(user_name: "thai1")
user1.password = '123456'
user1.save!

user2 = User.new(user_name: "thai2")
user2.password = '123456'
user2.save

user3 = User.new(user_name: "thai3")
user3.password = '123456'
user3.save

user4 = User.new(user_name: "thai4")
user4.password = '123456'
user4.save

puts "Create 4 users"

cat1 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart,
        user_id: user1.id
      )

cat2 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart,
        user_id: user2.id
      )

cat3 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart,
        user_id: user3.id
      )

cat4 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart,
        user_id: user4.id
      )

cat5 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart,
        user_id: user1.id
      )

puts "Create 5 cats"


rental1 = CatRentalRequest.create!(
          cat_id: cat1.id,
          user_id: user2.id,
          start_date: Date.new(2017,8,8),
          end_date: Date.new(2017,8,27)
          )

rental2 = CatRentalRequest.create!(
          cat_id: cat1.id,
          user_id: user3.id,
          start_date: Date.new(2017,9,8),
          end_date: Date.new(2017,9,27)
          )

rental3 = CatRentalRequest.create!(
          cat_id: cat2.id,
          user_id: user4.id,
          start_date: Date.new(2017,10,8),
          end_date: Date.new(2017,10,27),
          status: 'APPROVED'
          )

puts "create 3 rental requests, last rental is Approved"

# rental = CatRentalRequest.new(cat_id: 2, start_date: Date.new(2017,10,8), end_date: Date.new(2017,10,27))
