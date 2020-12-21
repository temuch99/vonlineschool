class CreateTextLections < ActiveRecord::Migration[6.0]
  def change
    create_table :text_lections do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :lection
      t.string :title
    end
  end
end
