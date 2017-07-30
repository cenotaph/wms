class CreateJoinTableUsersTeachiglevels < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :teachinglevels do |t|
      # t.index [:user_id, :teachinglevel_id]
      # t.index [:teachinglevel_id, :user_id]
    end
  end
end
