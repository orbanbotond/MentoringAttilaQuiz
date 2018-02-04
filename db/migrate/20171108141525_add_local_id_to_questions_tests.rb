class AddLocalIdToQuestionsTests < ActiveRecord::Migration[5.1]
  def change
    add_column :questions_tests, :local_id, :integer
  end
end
