class AddLegacyStudentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :legacy_student, :boolean
  end
end
