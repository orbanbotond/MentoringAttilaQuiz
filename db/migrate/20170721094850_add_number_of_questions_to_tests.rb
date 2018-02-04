class AddNumberOfQuestionsToTests < ActiveRecord::Migration[5.1]
  def change
    add_column :tests, :number_of_questions, :integer
  end
end
