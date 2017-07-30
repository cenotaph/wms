class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.integer :teacher_id, foreign_key: true
      t.boolean :teacher_approved, null: false, default: false
      t.boolean :fee_paid, null: false, default: false
      t.string :location
      t.string :custom_location
      t.text :notes
      t.datetime :requested_start
      t.datetime :requested_finish

      t.timestamps
    end
  end
end
