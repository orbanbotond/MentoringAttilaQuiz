class AddDeletedToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :deleted, :boolean
  end
end
