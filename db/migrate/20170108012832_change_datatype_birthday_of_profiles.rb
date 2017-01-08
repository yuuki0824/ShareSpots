class ChangeDatatypeBirthdayOfProfiles < ActiveRecord::Migration
  def change
    change_column :profiles, :birthday, :date
  end
end
