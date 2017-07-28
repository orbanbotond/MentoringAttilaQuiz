class QuestionsTest < ApplicationRecord
  belongs_to :test
  belongs_to :question

  accepts_nested_attributes_for :test
  accepts_nested_attributes_for :question

  delegate :answers, :to => :question, :prefix => true
  delegate :each, :find, :to => :question_answers, :prefix => true

  def answered_correct?
    question_answers.where(id: answer_ids) == question_answers.where(correct: true)
  end

  def answered?
    answer_ids.present?
  end

  def answer_marked?(answer)
    answer_ids.include? answer.id
  end
end
