require "spec_helper"
require_relative "../../../../app/concepts/answer/operation/create"

RSpec.describe Answer::Create do
  let (:valid_params) { {name: "1", correct: true} }
  let (:invalid_params) { {name: "", correct: false} }

  context "with valid params" do
    it "succeds" do
      question = Question.new
      question.save!
      result = Answer::Create.( {question_id: question.id, answer: valid_params} )
      p result
      expect( result.success? ).to be_truthy
      expect(result["model"]).to be_persisted
      expect(result["model"].name).to eq("1")
      expect(result["model"].correct).to be true
      expect(Answer.last.name).to eq("1")
      expect(Answer.last.correct).to be true
    end
  end

  context "name too short" do
    it "fails" do
      result = Answer::Create.( {answer: invalid_params} )
      expect(result["result.contract.default"].errors.messages).to eq(:name => ["size cannot be less than 2"])
      expect(result).to be_failure
      expect(Answer.last).to be_nil
    end
  end
end