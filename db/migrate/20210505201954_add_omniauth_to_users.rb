class AddOmniauthToUsers < ActiveRecord::Migration[6.0]
	def change
		remove_index :users, :email

		remove_column :users, :email, :string
		# remove_column :users, :encrypted_password, :string

		# remove_column :users, :remember_created_at, :datetime

		add_column :users, :provider, :string
		add_column :users, :uid, :string
		add_column :users, :nickname, :string
		add_column :users, :password_digest, :string
		add_column :users, :activated, :boolean, default: false
		add_column :users, :activation_token, :string

		#Trackable
		# add_column :users, :sign_in_count, :integer, default: 0, null: false
		# add_column :users, :current_sign_in_at, :datetime
		# add_column :users, :last_sign_in_at, :datetime
		# add_column :users, :current_sign_in_ip, :inet
		# add_column :users, :last_sign_in_ip, :inet

		add_index :users, :uid, unique: true
		add_index :users, :nickname, unique: true
	end
end
