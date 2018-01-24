class Category < ApplicationRecord
  resourcify

  has_many :questions

  def number_of_questions
    Question.
      where(:category_id => id).
      where(:deleted => false).
      size
  end
end
