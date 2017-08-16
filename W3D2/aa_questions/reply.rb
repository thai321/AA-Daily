require_relative 'questions_database'

class Reply
  attr_reader :id, :title, :body, :user_id, :question_id, :parent_id

  def self.all
    replies = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    replies.empty? ? nil : replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.questions_id = ?
    SQL

    replies.empty? ? nil : replies.map { |rep| Reply.new(rep) }
  end

  def initialize(opts)
    @id = opts['id']
    @title = opts['title']
    @body = opts['body']

    @user_id = opts['user_id']
    @questions_id = opts['questions_id']
    @parent_id = opts['parent_id']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def author
    User.find_by_user_id(@user_id)
  end

  def question
    Question.find_by_author_id(@user_id)
  end

  def parent_reply
    parent = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    parent.empty? ? nil : Reply.new(parent.first)
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.parent_id = ?
    SQL

    children.empty? ? nil : children.map { |child| Reply.new(child) }
  end

end
