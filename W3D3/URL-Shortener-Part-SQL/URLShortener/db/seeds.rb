# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p1 = User.create!(email: "m.wei210@gmail.com")
p2 = User.create!(email: "thai@gmail.com", permium: true)
p3 = User.create!(email: "kevin@gmail.com")
puts "Created 2 users"
#
url1 = ShortenedUrl.create_url(p1, "https://github.com/appacademy/curriculum/blob/master/sql/projects/url_shortener/README.md")
url2 = ShortenedUrl.create_url(p2, "https://apidock.com/rails/ActiveRecord/Base/exists%3F/class")
url3 = ShortenedUrl.create_url(p1, "http://progress.appacademy.io/me")
url4 = ShortenedUrl.create_url(p2, "https://stackoverflow.com/questions/40927760/how-to-use-ctrl-l-to-clear-rails-pry-or-irb-console")
puts "Created 4 URLs"

v1 = Visit.record_visit!(p1.id, url2.id)
v2 = Visit.record_visit!(p2.id, url3.id)
v3 = Visit.record_visit!(p1.id, url4.id)
v4 = Visit.record_visit!(p2.id, url1.id)
v5 = Visit.record_visit!(p2.id, url1.id)
v6 = Visit.record_visit!(p3.id, url1.id)
puts "Created 6 Visits Records"


t1 = TagTopic.create(topic: "GitHub")
t2 = TagTopic.create(topic: "API")
t3 = TagTopic.create(topic: "App Academy")
t4 = TagTopic.create(topic: "Stack Over Flow")
puts "Created 4 topics"

tag_join1 = Tagging.create(topic_id: t1.id, url_id: url1.id)
tag_join2 = Tagging.create(topic_id: t2.id, url_id: url2.id)
tag_join3 = Tagging.create(topic_id: t3.id, url_id: url3.id)
tag_join4 = Tagging.create(topic_id: t4.id, url_id: url4.id)
tag_join4a = Tagging.create(topic_id: t4.id, url_id: url1.id)
puts "Created Tag Join for TagTopic and Url"
