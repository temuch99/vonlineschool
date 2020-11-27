class CreateSurveyAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :survey_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :result, default: 0
      t.boolean :done, default: false
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
