class AddImageToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :image, :string
  end
end
