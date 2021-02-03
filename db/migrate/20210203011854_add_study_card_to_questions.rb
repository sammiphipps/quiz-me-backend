class AddStudyCardToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :study_card, :boolean
  end
end
