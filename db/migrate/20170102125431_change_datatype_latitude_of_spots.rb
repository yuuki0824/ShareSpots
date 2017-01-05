class ChangeDatatypeLatitudeOfSpots < ActiveRecord::Migration
  def change
    change_column :spots, :latitude, :decimal, precision: 9, scale: 6
    change_column :spots, :longitude, :decimal, precision: 10, scale: 6
  end
end
