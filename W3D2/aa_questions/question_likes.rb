require_relative 'questions_database'
require 'byebug'

class QuestionLikes

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id
      FROM
        users
      JOIN
        question_likes ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
      SQL

    likers.empty? ? nil : likers.map { |h| h.map { |k, v| User.find_by_user_id(v) } }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        SUM(question_likes.likes) AS num
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL

    num_likes.first['num']
  end

  def initialize(opts)
    @id = opts['id']
    @likes = opts['likes']

    @user_id = opts['user_id']
    @questions_id = opts['questions_id']
  end


end
