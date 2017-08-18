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
    answer_choices = self.question.answer_choices.includes(:responses)

    all_responses = []

    answer_choices.each do |answer_choice|
      # byebug
      responses = answer_choice.responses
      responses.each do |response|
        all_responses << response if answer_choice.id == self.answer_choice_id
      end
    end
    # byebug
    all_responses
  end

end
