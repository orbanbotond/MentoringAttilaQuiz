require "spec_helper"
require_relative "../../../../app/concepts/category/operation/create"

RSpec.describe Category::Create do
  let (:valid_params) { {name: "Ca", description: "desc"} }
  let (:invalid_params) { {name: "C", description: "a12"} }
  context "with valid params" do
    it "succeds" do
      result = Category::Create.( {category: valid_params} )
      expect( result.success? ).to be_truthy
      expect(result["model"]).to be_persisted
      expect(result["model"].name).to eq("Ca")
      expect(result["model"].description).to eq("desc")
      expect(Category.last.name).to eq("Ca")
      expect(Category.last.description).to eq("desc")
    end
  end

  context "name too short" do
    it "fails" do
      result = Category::Create.( {category: invalid_params} )
      expect(result["result.contract.default"].errors.messages).to eq(:name => ["size cannot be less than 2"])
      expect(result).to be_failure
      expect(Category.last).to be_nil
    end
  end
end