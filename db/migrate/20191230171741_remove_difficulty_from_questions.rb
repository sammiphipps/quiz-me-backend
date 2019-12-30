class RemoveDifficultyFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :difficulty
  end
end
