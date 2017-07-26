class Test < ApplicationRecord
  has_many :questions_tests
  has_many :questions, through: :questions_tests
  accepts_nested_attributes_for :questions_tests

  attr_writer :current_step

  #validate :has_chosen_category?

  def has_chosen_category?
    if params["categories"].size == 0
      error.add(:number_of_questions, "No chosen categories")
    end
  end

  def current_step(index)
    steps = []
    questions_tests.each do |variable|
      steps << 'question'
      steps << 'show_correct'
    end
    steps << 'evaluate'
    steps[index]
  end
end
