class CreateQuestionsTests < ActiveRecord::Migration[5.1]
  def change
    create_table :questions_tests do |t|
      t.references :question, foreign_key: true
      t.references :test, foreign_key: true
    end
  end
end
