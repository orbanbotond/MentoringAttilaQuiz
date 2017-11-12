class Answer < ApplicationRecord
  resourcify

  has_paper_trail

  belongs_to :question, touch: true
  validates :name, presence: true, length: { in: 1..20 }

  update_index 'question#question' do
    previous_changes['question_id'] || question
  end
end
