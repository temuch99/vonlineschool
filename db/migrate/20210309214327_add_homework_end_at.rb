class AddHomeworkEndAt < ActiveRecord::Migration[6.0]
  def change
  	add_column :lessons, :homework_end_at, :datetime, default: Time.now + 3600 * 12 * 7
  end
end
