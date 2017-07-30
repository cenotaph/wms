class CreateSpecialavailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :specialavailabilities do |t|
      t.references :user, foreign_key: true
      t.date :date
      t.time :open_time
      t.time :close_time
      t.boolean :is_available
      t.date :recur_until

      t.timestamps
    end
  end
end
