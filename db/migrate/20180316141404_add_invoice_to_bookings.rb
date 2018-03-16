class AddInvoiceToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :invoice, :string
    add_column :bookings, :invoice_content_type, :string
    add_column :bookings, :invoice_size, :integer, length: 8
  end
end
