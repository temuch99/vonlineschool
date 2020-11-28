class CreateHomeworkAsnwers < ActiveRecord::Migration[6.0]
  def change
    create_table :homework_answers do |t|
      t.string :answer
      t.references :homework_attempt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
