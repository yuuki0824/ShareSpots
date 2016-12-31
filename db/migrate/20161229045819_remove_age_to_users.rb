class RemoveAgeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :age,:string
    remove_column :users, :self_introduction, :string
  end
end
