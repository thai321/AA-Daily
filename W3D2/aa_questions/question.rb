require_relative 'questions_database'

class Question
  attr_reader :id, :tile, :body, :user_id

  def self.all
    questions = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    questions.map { |question| Question.new(question) }
  end

  def self.find_by_question_id(question_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL

    questions.empty? ? nil : questions.map { |q| Question.new(q) }
  end


  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    questions.empty? ? nil : questions.map { |q| Question.new(q) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def initialize(opts)
    @id = opts['id']
    @title = opts['title']
    @body = opts['body']
    @user_id = opts['user_id']
  end

  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        users
      JOIN questions
        ON users.id = questions.user_id
      WHERE
        users.id = ?
    SQL

    User.new(user.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

end


=begin
load 'question_follow.rb'
load 'user.rb'

load 'question.rb'

load 'question_likes.rb'
=end
