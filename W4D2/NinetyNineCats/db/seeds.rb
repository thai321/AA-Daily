# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

COLORS = ["White", "Green", "Red", "Orange", "Brown", "Yellow", "Blue"].freeze

Cat.destroy_all
CatRentalRequest.destroy_all

cat1 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart
      )

cat2 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart
      )

cat3 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart
      )

cat4 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart
      )

cat5 = Cat.create!(
        birth_date: Faker::Date.backward(2000).strftime("%Y/%m/%d"),
        color: COLORS.sample,
        name: Faker::Cat.unique.name,
        sex: ["M", "F"].sample,
        description: Faker::Hacker.say_something_smart
      )

puts "Create 5 cats"


rental1 = CatRentalRequest.create!(
          cat_id: 2,
          start_date: Date.new(2017,8,8),
          end_date: Date.new(2017,8,27)
          )

rental2 = CatRentalRequest.create!(
          cat_id: 2,
          start_date: Date.new(2017,9,8),
          end_date: Date.new(2017,9,27)
          )

rental3 = CatRentalRequest.create!(
          cat_id: 2,
          start_date: Date.new(2017,10,8),
          end_date: Date.new(2017,10,27),
          status: 'APPROVED'
          )

puts "create 3 rental requests, last rental is Approved"

# rental = CatRentalRequest.new(cat_id: 2, start_date: Date.new(2017,10,8), end_date: Date.new(2017,10,27))
