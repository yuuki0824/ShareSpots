class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :date
      t.string :address
      t.string :description
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
      t.index [:user_id, :created_at]
    end
  end
end
