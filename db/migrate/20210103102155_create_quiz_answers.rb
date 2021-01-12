class CreateQuizAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_answers do |t|
      t.string :answer
      t.boolean :is_correct, null:false, default: false
      t.references :quiz_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
