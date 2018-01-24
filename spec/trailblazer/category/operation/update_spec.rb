require "spec_helper"
require_relative "../../../../app/concepts/category/operation/update"

RSpec.describe Category::Update do
  let (:myCategory) { Category::Create.( { category: {name: "Category", description: "desc"}} )["model"] }
  let (:valid_params) { {name: "Ca", description: "newDesc"} }
  let (:invalid_params) { {name: "C", description: "a12"} }

  context "with valid params" do
    it "succeds" do
      result = Category::Update.( {id: myCategory.id, category: valid_params} )
      
      expect( result.success? ).to be_truthy
      expect(result["model"]).to be_persisted
      expect(result["model"].name).to eq("Ca")
      expect(result["model"].description).to eq("newDesc")
      expect(Category.last.name).to eq("Ca")
      expect(Category.last.description).to eq("newDesc")
    end
  end

  context "name too short" do
    it "fails" do
      result = Category::Update.( {id: myCategory.id, category: invalid_params} )
      
      expect(result).to be_failure
      expect(result["result.contract.default"].errors.messages).to eq(:name => ["size cannot be less than 2"])
      expect(Category.last.name).to eq("Category")
      expect(Category.last.description).to eq("desc")
    end
  end
end