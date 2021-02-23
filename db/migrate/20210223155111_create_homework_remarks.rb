class CreateHomeworkRemarks < ActiveRecord::Migration[6.0]
  def change
    create_table :homework_remarks do |t|
      t.string :remark
      t.references :homework_attempt, null: false, foreign_key: true

      t.timestamps
    end
  end
end
