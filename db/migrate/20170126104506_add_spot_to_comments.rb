class AddSpotToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :spot, index: true, foreign_key: true
  end
end
