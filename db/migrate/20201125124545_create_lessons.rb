class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :text_lection
      t.text :video_lection
      t.text :lection_links
      t.integer :survey_size, default: 5
      t.text :description
      t.integer :survey_duration, default: 45
      t.integer :position
      t.integer :attempts, default: 3
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
