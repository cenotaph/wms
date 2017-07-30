class AddCustomHoursToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :custom_hours, :string
  end
end
