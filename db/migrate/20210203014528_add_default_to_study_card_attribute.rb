class AddDefaultToStudyCardAttribute < ActiveRecord::Migration[6.0]
  def change
    change_column_default :questions, :study_card, false
  end
end
