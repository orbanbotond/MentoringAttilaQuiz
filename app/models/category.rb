class Category < ApplicationRecord
  resourcify

  validates :name, presence: true, length: 2..20
  has_many :questions

  def number_of_questions
    Question.
      where(:category_id => id).
      where(:deleted => false).
      size
  end
end
