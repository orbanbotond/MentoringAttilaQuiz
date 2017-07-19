class Answer < ApplicationRecord
  belongs_to :question
  validates :name, presence: true, length: { in: 1..20 }

  update_index 'question#question' do
    previous_changes['question_id'] || question
  end

  scope :search2, -> (search) { where("name LIKE ?", "%#{search}%") }
end
