class Test < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :question_test_ids
  accepts_nested_attributes_for :questions

  attr_writer :current_step

  #validate :has_chosen_category?

  def has_chosen_category?
    if params["categories"].size == 0
      error.add(:number_of_questions, "No chosen categories")
    end
  end

  def current_step(index)
    steps = []
    questions.each do |variable|
      steps << 'question'
      steps << 'show_correct'
    end
    steps << 'evaluate'
    steps[index]
  end
end
