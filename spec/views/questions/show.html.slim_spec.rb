require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :name => "NameMin10character",
      :category => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/NameMin10character/)
    expect(rendered).to match(//)
  end
end
