class Test < ApplicationRecord
  has_many :questions_tests
  has_many :questions, through: :questions_tests
  accepts_nested_attributes_for :questions_tests

  attr_writer :current_step

  #validate :has_chosen_category?

  validate :is_any_question?

  def is_any_question?
    if questions.size == 0
      errors.add(:number_of_questions, "No questions")
    end
  end

  def has_chosen_category?
    if params["categories"].size == 0
      errors.add(:number_of_questions, "No chosen categories")
    end
  end

  def create_steps(with_show_correct)
    @@steps = []
    questions_tests.each do |variable|
      @@steps << 'question'
      @@steps << 'show_correct' if with_show_correct
    end
    @@steps << 'evaluate'
  end

  def current_step(index)
    @@steps[index]
  end
end
