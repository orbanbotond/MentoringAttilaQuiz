class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, :dependent => :destroy
  
  has_many :questions_tests
  has_many :tests, through: :questions_tests
  accepts_nested_attributes_for :questions_tests
  
  update_index('question#question') { self }

  validates :name, presence: true, length: { in: 10..80 }
  validate :has_correct_answer?
  validate :number_of_answers

  scope :search2, -> (search) { where("name LIKE ?", "%#{search}%") }

  #TODO
  #predicate methods can not have side effects 
  #hint change to validate_correct_answers
  #hint make it private
  def has_correct_answer?
    @test = false
    answers.each do |answer|
      #TODO please use the predicate method 'correct?'
      @test = @test || answer.correct
    end

    if @test == false
      errors.add(:name, "No correct answer")
    end

    #TODO
    # please consider this:
    #errors.add(:name, "no correct answer") if answers.none?{|x|x.correct?}
    #TODO homework:
    # exercise with Enumeration#none? Enumeration#all? Enumeration#any?
  end

  #TODO
  #it seems like a calculated field. calculated field can not have side effect.
  #hint change to validate_number_of_answers
  #hint make it private
  def number_of_answers
    if answers.length<2
      errors.add(:name, "Minimum number of answers: 2")
    elsif answers.length>5
      errors.add(:name, "Too many answers (max 5)")
    end
  end

end
