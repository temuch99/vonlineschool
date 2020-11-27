class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :avatar, :string
    add_column :users, :description, :text
    add_column :users, :parent_email, :string
  end
end
