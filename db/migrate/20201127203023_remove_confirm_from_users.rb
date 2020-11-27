class RemoveConfirmFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, column: :confirmation_token
    remove_index :users, column: :unlock_token

  	remove_column :users, :confirmation_token, :string
  	remove_column :users, :confirmed_at, :datetime
  	remove_column :users, :confirmation_sent_at, :datetime
  	remove_column :users, :unconfirmed_email, :string

    ## Lockable
    remove_column :users, :failed_attempts, :integer
  	remove_column :users, :unlock_token, :string
  	remove_column :users, :locked_at, :datetime
  end
end
