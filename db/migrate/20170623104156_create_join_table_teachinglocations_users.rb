class CreateJoinTableTeachinglocationsUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :teachinglocations, :users do |t|

    end
  end
end
