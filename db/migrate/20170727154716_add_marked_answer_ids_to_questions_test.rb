class AddMarkedAnswerIdsToQuestionsTest < ActiveRecord::Migration[5.1]
  def change
    add_column :questions_tests, :answer_ids, :integer, array:true, default: []
  end
end
