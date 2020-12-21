class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.integer :position

      t.timestamps
    end

    add_reference :lessons, :section, foreign_key: :true, null: false
  end
end
