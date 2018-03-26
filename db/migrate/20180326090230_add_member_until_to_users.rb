class AddMemberUntilToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :member_until, :date
  end
end
