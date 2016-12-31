class RemoveGraduateToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :graduate, :string
  end
end
