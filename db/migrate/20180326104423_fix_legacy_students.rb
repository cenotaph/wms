class FixLegacyStudents < ActiveRecord::Migration[5.1]
  def change
    execute("UPDATE users SET member_until = '" + (Time.current.to_date + 1.year).strftime('%Y-%m-%d') + "' WHERE approved_student is true and legacy_student is true")
  end
end
