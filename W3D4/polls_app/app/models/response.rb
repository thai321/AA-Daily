# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#

# Join table between User and AnswerChoice
class Response < ApplicationRecord

  validate :not_duplicate_response, unless: -> { answer_choice.nil? }

  validate :respondent_is_not_poll_author, unless: -> { answer_choice.nil? }

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: 'AnswerChoice'

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end


  def respondent_already_answered?
    sibling_responses.exisit?(user_id: self.user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << "Can't response twice for this question"
    end
  end

  def respondent_is_not_poll_author
    # poll_author_id = self.answer_choice.question.poll.user_id

    poll_author_id = Poll
      .joins(questions: :answer_choices)
      .where('answer_choices.id = ?', self.answer_choice_id)
      .pluck('polls.user_id')
      .first

    if poll_author_id == self.user_id
      errors[:user_id] << 'cannot be poll author'
    end
  end

end
