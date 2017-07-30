class AddCvToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cv, :string
    add_column :users, :cv_content_type, :string
    add_column :users, :cv_size, :integer, limit: 8
  end
end
