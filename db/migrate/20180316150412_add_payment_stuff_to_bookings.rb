class AddPaymentStuffToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :paid, :boolean
    add_column :bookings, :paid_at, :datetime
    add_column :bookings, :paymenttype_id, :integer
    add_column :bookings, :stripe_token, :string
  end
end
