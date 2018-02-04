class Test < ApplicationRecord
  resourcify

  has_many :questions_tests
  has_many :questions, through: :questions_tests
  accepts_nested_attributes_for :questions_tests
  belongs_to :member

  attr_writer :current_step

  delegate :sort, :size, :to => :questions, :prefix => true
  delegate :each, :size, :all, :order, :paginate, :to => :questions_tests, :prefix => true

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

  def is_current_step?(step_name, index)
    @@steps[index].eql? step_name
  end

  def is_previous_step?(step_name, index)
    @@steps[index - 1].eql? step_name
  end

  def number_of_correct_answers
    questions_tests.select { |questions_test|
      questions_test.answered_correct?
    }.size
  end

  def find_questions_test_by_question(question)
    questions_tests.where(:question_id => question.id).first
  end

  private

end
