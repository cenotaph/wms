class CreateTeachinglevels < ActiveRecord::Migration[5.1]
  def change
    create_table :teachinglevels do |t|
      t.string :name

      t.timestamps
    end
    Teachinglevel.create(name: 'Master class')
    Teachinglevel.create(name: 'Intermediate')
    Teachinglevel.create(name: 'Beginner')
    Teachinglevel.create(name: 'Beginner')
    Teachinglevel.create(name: 'Lessons for kids')
    add_column :users, :custom_teaching_level, :string
  end
end
