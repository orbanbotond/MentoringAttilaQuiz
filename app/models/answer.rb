class Answer < ApplicationRecord
  attr_accessor :question_id, :name
  belongs_to :question
end
