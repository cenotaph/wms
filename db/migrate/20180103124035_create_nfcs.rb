class CreateNfcs < ActiveRecord::Migration[5.1]
  def change
    create_table :nfcs do |t|
      t.references :user, foreign_key: true
      t.string :tag_address, length: 20
      t.boolean :active
      t.datetime :last_used
      t.boolean :collected

      t.timestamps
    end
  end
end
