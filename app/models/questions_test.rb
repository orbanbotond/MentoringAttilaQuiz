class QuestionsTest < ApplicationRecord
  belongs_to :test
  belongs_to :question

  accepts_nested_attributes_for :test
  accepts_nested_attributes_for :question
end
