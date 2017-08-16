require_relative 'questions_database'
require 'byebug'

# Join table between user table and question table

class QuestionFollow

  attr_reader :user_id, :question_id

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id
      FROM
        users
      JOIN
        question_follows ON question_follows.user_id = users.id
      WHERE
        question_id = ?
      SQL

    followers.empty? ? nil : followers.map { |h| h.map { |k, v| User.find_by_user_id(v) } }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        questions.id = ?
    SQL

    return nil if questions.empty?
    questions.map { |h| h.map { |k, v| Question.find_by_author_id(v) } }
  end

  def self.most_followed_questions(n)
    most_follow = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id , COUNT(questions.user_id)
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.user_id) DESC
      LIMIT ?
    SQL

    most_follow.map { |h| Question.find_by_question_id(h['id']) }
  end

  def initialize(opts)
    @id = opts['id']
    @user_id = opts['user_id']
    @questions_id = opts['questions_id']
  end

end
