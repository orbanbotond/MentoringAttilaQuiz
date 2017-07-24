class Test < ApplicationRecord
  has_and_belongs_to_many :questions
  accepts_nested_attributes_for :questions

  #validate :has_chosen_category?

  def has_chosen_category?
    if params["categories"].size == 0
      error.add(:number_of_questions, "No chosen categories")
    end
  end

end
