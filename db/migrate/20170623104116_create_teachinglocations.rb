class CreateTeachinglocations < ActiveRecord::Migration[5.1]
  def self.up
    create_table :teachinglocations do |t|
      t.string :name

      t.timestamps
    end
    add_column :users, :custom_teachinglocation, :string
    Teachinglocation.create(name: 'Skype')
    Teachinglocation.create(name: "Helsinki and I need to use the School's space")
    Teachinglocation.create(name: 'Helsinki at my own space')
    Teachinglocation.create(name: 'In my local city')
  end
  
  def self.down
    drop_table :teachinglocations
    remove_column :users, :custom_teachinglocation
  end
end
