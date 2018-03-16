class AddPaymentStuffToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :paid, :boolean
    add_column :invoices, :paid_at, :datetime
    add_column :invoices, :paymenttype_id, :integer
    add_column :invoices, :stripe_token, :string
  end
end
