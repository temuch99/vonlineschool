class CreateSurveyAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_answers do |t|
      t.references :survey_attempt, null: false, foreign_key: true
      t.string :answer, null: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
