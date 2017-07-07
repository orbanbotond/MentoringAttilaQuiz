class Answer < ApplicationRecord
  belongs_to :question
  validates :name, presence: true, length: { in: 1..20 }
end
