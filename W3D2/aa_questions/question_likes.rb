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
  
  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id
      FROM
        questions
      JOIN
        question_likes ON question_likes.user_id = questions.user_id
      WHERE
        questions.user_id = ?
    SQL
    
    return nil if questions.empty?
    questions.map { |h| Question.find_by_author_id(h['id']) }
  end
  
  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*)
      LIMIT ?
    SQL
    
    questions.map { |h| Question.find_by_question_id(h['id']) }
  end
  
  def initialize(opts)
    @id = opts['id']
    @likes = opts['likes']

    @user_id = opts['user_id']
    @questions_id = opts['questions_id']
  end


end
