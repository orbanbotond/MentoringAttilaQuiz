class Question < ApplicationRecord
	attr_accessor :name, :description, :answers_attributes
	has_many :answers
	accepts_nested_attributes_for :answers
end
