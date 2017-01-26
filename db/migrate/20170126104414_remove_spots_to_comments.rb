class RemoveSpotsToComments < ActiveRecord::Migration
  def change
    remove_column :comments, :spots, :string
  end
end
