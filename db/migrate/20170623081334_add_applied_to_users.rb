class AddAppliedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :applied_as_teacher, :boolean
    add_column :users, :applied_as_student, :boolean
    add_column :users, :approved_teacher, :boolean
    add_column :users, :approved_student, :boolean
  end
end
