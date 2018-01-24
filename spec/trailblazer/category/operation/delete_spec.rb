require "spec_helper"
require_relative "../../../../app/concepts/category/operation/delete"

RSpec.describe Category::Delete do
  let (:myCategory) { Category::Create.( { category: {name: "Category", description: "desc"}} )["model"] }

  it "deletes a category" do
    result = Category::Delete.( {id: myCategory.id} )
    
    expect( result.success? ).to be_truthy
    expect(Category.last).to be_nil
  end
end