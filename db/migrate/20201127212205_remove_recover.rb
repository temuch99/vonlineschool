class RemoveRecover < ActiveRecord::Migration[6.0]
  def change
  	remove_index :users, column: :reset_password_token

  	## Recoverable
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
  end
end
