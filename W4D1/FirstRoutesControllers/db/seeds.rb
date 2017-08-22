# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 10.times { User.create(name: Faker::Name.unique.name, email: Faker::Internet.unique.email) }
# puts "Created 10 users"


User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all
puts "Delete the Old Database"

u1 = User.create(username: Faker::Name.unique.name)
u2 = User.create(username: Faker::Name.unique.name)
puts "Created 2 new arists"

art1 = Artwork.create(title: Faker::Cat.unique.name , image_url: Faker::Internet.unique.url, artist_id: u1.id )

art2 = Artwork.create(title: Faker::Cat.unique.name , image_url: Faker::Internet.unique.url, artist_id: u2.id )

puts "Created 2 artworks"

ArtworkShare.create(artwork_id: art1.id, viewer_id: u2.id)
ArtworkShare.create(artwork_id: art2.id, viewer_id: u2.id)

puts "Created 2 artwork-shares"


c1 = Comment.create(body: Faker::Hacker.unique.say_something_smart, user_id: u1.id, artwork_id: art1.id)
c2 = Comment.create(body: Faker::Hacker.unique.say_something_smart, user_id: u2.id, artwork_id: art2.id)
puts "Created 2 comments"
