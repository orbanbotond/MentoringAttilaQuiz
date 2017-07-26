class AddMarkedAnswerToQuestionsTest < ActiveRecord::Migration[5.1]
  def change
    add_column :questions_tests, :marked_answer, :string
  end
end
