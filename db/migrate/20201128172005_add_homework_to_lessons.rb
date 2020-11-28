class AddHomeworkToLessons < ActiveRecord::Migration[6.0]
  def change
  	add_column :lessons, :homework, :string
  end
end
