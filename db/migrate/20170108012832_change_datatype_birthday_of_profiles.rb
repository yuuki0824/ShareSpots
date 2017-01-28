class ChangeDatatypeBirthdayOfProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :birthday, 'date USING (birthday::date)'
  end
end
