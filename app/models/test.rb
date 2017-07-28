class Test < ApplicationRecord
  has_many :questions_tests
  has_many :questions, through: :questions_tests
  accepts_nested_attributes_for :questions_tests

  attr_writer :current_step

  delegate :sort, :size, :to => :questions, :prefix => true
  delegate :each, :size, :all, :paginate, :to => :questions_tests, :prefix => true

  #[OK] TODO rename with_show_correct to something meaningfull
  def create_steps(show_correct_answers_option)
    @@steps = []
    questions_tests.each do |variable|
      @@steps << 'question'
      @@steps << 'show_correct' if show_correct_answers_option
    end
    @@steps << 'evaluate'
  end

  def current_step(index)
    @@steps[index]
  end

  def number_of_correct_answers
    questions_tests.select { |questions_test|
      questions_test.answered_correct?
    }.size
  end

  private
    #TODO predicate method can't have side effect
    #hint rename to something meaningfull
    #please make it private
end
