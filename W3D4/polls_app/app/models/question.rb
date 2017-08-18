# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  validates :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: 'AnswerChoice'

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_n_plus_1
    results = {}

    self.answer_choices.each do |choice|
      results[choice.text] = choice.responses.count
    end

    results
  end

  def results_2_queries
    results = {}
    choices = self.answer_choices.includes(:responses)

    choices.each do |choice|
      results[choice.text] = choice.responses.length
    end

    results
  end

  def results_1_query_SQL
    choices = AnswerChoice.find_by_sql([<<-SQL, id])
      SELECT
        answer_choices.text, COUNT(responses.id) AS num_responses
      FROM
        answer_choices
      LEFT OUTER JOIN responses
        ON answer_choice_id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id

    SQL
    # byebug
    results = {}
    choices.each do |choice|
      results[choice.text] = choice.num_responses
    end
    results
  end

  def results
    # 1-query way 
    choices = self.answer_choices
      .select("answer_choices.text, COUNT(responses.id) AS num_responses")
      .joins(<<-SQL)
        LEFT OUTER JOIN responses
          ON answer_choices.id = responses.answer_choice_id
        SQL
      .group("answer_choices.id")

    results = {}
    choices.each do |choice|
      results[choice.text] = choice.num_responses
    end
    results
  end

end
