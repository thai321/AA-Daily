# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..10).each do |i|
  User.create(username: "user#{i}")
  Poll.create(title: "poll#{i}", user_id: i)
  Question.create(text: "question#{i}", poll_id: i)
  AnswerChoice.create(text: "choice#{i}", question_id: i)
  Response.create(user_id: i, answer_choice_id: i)
end
puts "Create 10 users, polls, questions, answer_choices, and responses"

p1_a = Poll.create(title: "poll1_a", user_id: 1)
puts "Create Poll p1_a for user 1"


Response.create(user_id: 1, answer_choice_id: 1)
Response.create(user_id: 2, answer_choice_id: 1)
puts "Create response between user 1 and answer_choice 1"

q1a = Question.create(text: "question1a", poll_id: p1_a.id)
puts "Create Question for poll_id is p1_a 11)"

choice11 = AnswerChoice.create(text: "choice11", question_id: 1)
choice12 = AnswerChoice.create(text: "choice12", question_id: 1)
puts "Create 2 answer_choices"
