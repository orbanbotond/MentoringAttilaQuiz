class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true 
  validates :name, presence: true

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
