class AddInvoiceDueToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :invoice_due, :date
  end
end
