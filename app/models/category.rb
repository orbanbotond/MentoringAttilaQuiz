class Category < ApplicationRecord
  validates :name, presence: true

  #Add has_many question
end
