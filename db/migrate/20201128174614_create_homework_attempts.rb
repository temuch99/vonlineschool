class CreateHomeworkAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :homework_attempts do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :result, default: 0
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
