class AddReferenceToExtensionQuestion < ActiveRecord::Migration[6.0]
  def change
  	add_reference :extension_questions, :discipline, foreign_key: true, null: false
  	remove_reference :extension_questions, :course, foreign_key: true
  end
end
