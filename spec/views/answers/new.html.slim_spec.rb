require 'rails_helper'

RSpec.describe "answers/new", type: :view do
  before(:each) do
    assign(:answer, Answer.new(
      :name => "MyString",
      :correct => false,
      :question => nil
    ))
  end

  it "renders new answer form" do
    render

    assert_select "form[action=?][method=?]", answers_path, "post" do

      assert_select "input[name=?]", "answer[name]"

      assert_select "input[name=?]", "answer[correct]"

      assert_select "input[name=?]", "answer[question_id]"
    end
  end
end
