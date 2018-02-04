require 'rails_helper'

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  describe ".has_correct_answer" do
    context "no correct answer" do
      it "returns error" do
        answer1 = Answer.create(:name => "First answer", :correct => false)
        answer2 = Answer.create(:name => "Second answer", :correct => false)
        question = Question.create(:name => "Question")
        question.answers = [answer1, answer2]

        expect { question.has_correct_answer }.to raise_error
      end
    end

    context "has correct answer" do
      it "returns without error" do
        answer1 = Answer.create(:name => "First answer", :correct => true)
        answer2 = Answer.create(:name => "Second answer", :correct => false)
        question = Question.create(:name => "Question")
        question.answers = [answer1, answer2]

        expect { question.has_correct_answer }.to_not raise_error("No correct answer")
      end
    end
  end

  describe ".validate_number_of_answers" do
    context "less than 2 answers" do
      it "returns error" do

      end
    context "more than 5 answers" do
      it "returns error" do

      end
    end
    context "2 answers" do
      it "doesn't return error" do

      end
    end
    context "5 answers" do
      it "doesn't return error" do

      end
    end
  end

end
