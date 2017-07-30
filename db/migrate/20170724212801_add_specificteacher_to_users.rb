class AddSpecificteacherToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :specific_teacher, :string
  end
end
