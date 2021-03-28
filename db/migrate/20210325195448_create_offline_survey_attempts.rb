class CreateOfflineSurveyAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :offline_survey_attempts do |t|
    	t.references :user, null: false, foreign_key: true
		t.references :lesson, null: false, foreign_key: true
		t.integer :result, default: 0

    	t.timestamps
    end

    add_column :lessons, :is_offline_survey, :boolean, default: false
  end
end
