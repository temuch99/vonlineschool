class CreateQuizQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_questions do |t|
      t.string :question
      t.references :course, null: false, foreign_key: true
      t.integer :number, null: false

      t.timestamps
    end
  end
end
