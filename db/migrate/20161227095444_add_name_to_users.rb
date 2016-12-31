class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :age, :string
    add_column :users, :graduate, :string
    add_column :users, :self_introduction, :string
    
    add_index :users, :name
  end
end
