class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :user, foreign_key: true
      t.date :due_date
      t.string :description
      t.boolean :is_paid
      t.string :pdf
      t.string :pdf_content_type
      t.float  :amount
      t.integer :pdf_size, length: 8

      t.timestamps
    end
  end
end
