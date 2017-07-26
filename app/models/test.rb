class Test < ApplicationRecord
  has_many :questions_tests
  has_many :questions, through: :questions_tests
  accepts_nested_attributes_for :questions_tests

  attr_writer :current_step

  #validate :has_chosen_category?

  validate :is_any_question?

  #TODO predicate method can't have side effect
  #hint rename to something meaningfull
  #please make it private
  def is_any_question?
    if questions.size == 0
      errors.add(:number_of_questions, "No questions")
    end
  end

  #TODO sounds like a predicate method with a side effect.
  #please make it private
  #please rename
  def has_chosen_category?
    if params["categories"].size == 0
      errors.add(:number_of_questions, "No chosen categories")
    end
  end

  # TODO rename with_show_correct to something meaningfull
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
