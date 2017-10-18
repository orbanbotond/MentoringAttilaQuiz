class Question < ApplicationRecord
  resourcify

  belongs_to :category
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true 

  has_many :questions_tests
  has_many :tests, through: :questions_tests
  accepts_nested_attributes_for :questions_tests

  delegate :each, :to => :answers, :prefix => true
  
  update_index('question#question') { self }

  validates :name, presence: true, length: { in: 10..80 }
  validate :validate_correct_answers
  validate :validate_number_of_answers

  scope :search, -> (search) { where("name LIKE ?", "%#{search}%") }

  private
    #TODO
    #[OK]predicate methods can not have side effects 
    #[OK]hint change to validate_correct_answers
    #[OK]hint make it private
    def validate_correct_answers
      errors.add(:name, "No correct answer") if answers.none? {|x| x.correct?}

      #TODO
      #[OK]please consider this:
      #[OK]errors.add(:name, "no correct answer") if answers.none?{|x|x.correct?}
      #TODO homework:
      # exercise with Enumeration#none? Enumeration#all? Enumeration#any?
    end

    #TODO
    #[OK]it seems like a calculated field. calculated field can not have side effect.
    #[OK]hint change to validate_number_of_answers
    #[OK]hint make it private
    def validate_number_of_answers
      if answers.length<2
        errors.add(:name, "Minimum number of answers: 2")
      elsif answers.length>5
        errors.add(:name, "Too many answers (max 5)")
      end
    end

end
