class AddTimerToSurveyAttempt < ActiveRecord::Migration[6.0]
  def change
  	add_column :survey_attempts, :survey_end_at, :datetime
  	add_column :lessons, :survey_end_at, :datetime, default: Time.now + 3600 * 12 * 7
  end
end
