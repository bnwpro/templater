class AddColumnsToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :date, :string
    
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :password, :string
    add_column :users, :admin, :boolean, default: false
  end
end
