class Answer < ApplicationRecord
  resourcify

  belongs_to :question
  validates :name, presence: true, length: { in: 1..20 }

  update_index 'question#question' do
    previous_changes['question_id'] || question
  end
end
