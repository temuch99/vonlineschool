class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :task
      t.string :correct_answer
      t.references :lesson

      t.timestamps
    end
  end
end
