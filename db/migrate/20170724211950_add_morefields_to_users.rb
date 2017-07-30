class AddMorefieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :custom_experience, :string
    add_column :users, :custom_hasinstrument, :string
    add_column :users, :custom_havelessons, :string
    add_column :users, :custom_lessontime, :string
    add_column :users, :custom_instrumentgenre, :string
    add_column :users, :custom_teacher, :string
    add_column :users, :further_comments, :string
    add_column :users, :voucher, :string
  end
end
