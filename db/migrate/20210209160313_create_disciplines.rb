class CreateDisciplines < ActiveRecord::Migration[6.0]
  def change
    create_table :disciplines do |t|
      t.string :title

      t.timestamps
    end

    drop_table :extension_questions

    create_table :extension_questions do |t|
		t.string :task
		t.string :correct_answer
		t.integer :number, null: false
		t.references :discipline, null: false, foreign_key: true

		t.timestamps
    end
  end
end
