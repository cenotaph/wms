class CreateRegularavailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :regularavailabilities do |t|
      t.references :user, foreign_key: true
      t.integer :day_of_week
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end
end
