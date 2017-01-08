class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :age
      t.string :birthplace
      t.string :self_introducation
      t.integer :birthday

      t.timestamps null: false
    end
  end
end
