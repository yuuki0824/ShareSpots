class ChangeDatatypeBirthdayOfProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :birthday, 'date USING CAST(birthday AS date)'
  end
end
