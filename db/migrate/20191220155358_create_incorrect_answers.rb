class CreateIncorrectAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :incorrect_answers do |t|
      t.string :message
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
