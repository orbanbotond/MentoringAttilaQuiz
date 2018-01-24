require "spec_helper"
require_relative "../../../../app/concepts/category/operation/index"

RSpec.describe Category::Delete do
  let (:category1) { Category::Create.( { category: {name: "Category1", description: "desc1"}} )["model"] }
  let (:category2) { Category::Create.( { category: {name: "Category2", description: "desc2"}} )["model"] }

  context "2 categories" do
    it "returns all categories (2)" do
      category1
      category2
      result = Category::Index.()
      
      expect( result.success? ).to be_truthy
      expect( result["model"].length ).to satisfy { |value| value == 2 }
      expect( result["model"].find(category1.id).name).to eql(category1.name)
      expect( result["model"].find(category1.id).description).to eql(category1.description)
      expect( result["model"].find(category2.id).name).to eql(category2.name)
      expect( result["model"].find(category2.id).description).to eql(category2.description)
    end
  end

  context "0 categories" do
    it "returns 0 categories" do
      result = Category::Index.()
      
      expect( result.success? ).to be_truthy
      expect( result["model"].length ).to satisfy { |value| value == 0 }
    end
  end
end