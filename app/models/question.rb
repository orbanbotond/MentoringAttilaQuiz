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

  def has_correct_answer?
    @test = false
    answers.each do |answer|
      @test = @test || answer.correct
    end
    if @test == false
      errors.add(:name, "No correct answer")
    end
  end

  def number_of_answers
    if answers.length<2
      errors.add(:name, "Minimum number of answers: 2")
    elsif answers.length>5
      errors.add(:name, "Too many answers (max 5)")
    end
  end

end
