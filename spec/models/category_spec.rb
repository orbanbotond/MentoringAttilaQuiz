require 'rails_helper'

RSpec.describe Category, type: :model do
  describe ".number_of_questions" do
    context "0 question" do
      it "returns 0" do
        category = Category.create(:name => "myCategory")
        expect(category.number_of_questions).to eql(0)
      end
    end

    context "2 questions" do
      it "returns 2" do
        category = Category.create(:name => "m")
        question1 = Question.create(:name => "Question1", :category_id => category.id)
        question2 = Question.create(:name => "Question2", :category_id => category.id)
        question1.save!

        p category
        p question1

        expect(category.number_of_questions).to eql(2)
      end
    end
  end
end