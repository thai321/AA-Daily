require_relative 'questions_database'

class User

  attr_reader :id, :fname, :lname

  def self.all
    users = QuestionsDatabase.instance.execute("SELECT * FROM users")
    users.map { |user| User.new(user) }
  end

  def self.find_by_name(fname, lname)
    fname = "%#{fname}%"
    lname = "%#{lname}%"
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname LIKE ? AND lname LIKE ?
    SQL
    user.empty? ? nil : User.new(user.first)
  end

  def self.find_by_user_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    user.empty? ? nil : User.new(user.first)
  end
  
  def average_karma
    average = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT (DISTINCT questions.id) AS FLOAT) /  COUNT(question_likes.likes)
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?
    SQL
    
    average.first.values.first
  end

  def initialize(opts)
    @id = opts['id']
    @fname = opts['fname']
    @lname = opts['lname']
  end
  

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end
  
  def liked_questions
    QuestionLikes.liked_questions_for_user_id(@id)
  end
  
  
  def save
    
  end

end
