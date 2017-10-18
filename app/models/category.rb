class Category < ApplicationRecord
  resourcify

  validates :name, presence: true
  has_many :questions
end
