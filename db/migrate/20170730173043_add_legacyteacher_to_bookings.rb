class AddLegacyteacherToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :legacy_teacher, :string
  end
end
