class CreateGenresrelations < ActiveRecord::Migration[5.1]
  def change
    create_join_table :genres, :users
  end
end
