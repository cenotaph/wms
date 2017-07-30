class AddTeacheremailToLegacyteachers < ActiveRecord::Migration[5.1]
  def change
    add_column :legacyteachers, :email, :string
  end
end
