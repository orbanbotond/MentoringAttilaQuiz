class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers
  validates :name, presence: true
end
