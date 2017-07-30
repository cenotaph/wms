class CreateHowdidfinds < ActiveRecord::Migration[5.1]
  def change
    create_table :howdidfinds do |t|
      t.string :name

      t.timestamps
    end
    Howdidfind.create(name: 'Searched on web')
    Howdidfind.create(name: 'Facebook')
    Howdidfind.create(name: 'Friends')
    Howdidfind.create(name: 'Flyers or posters')
    add_column :users, :custom_howdidfind, :string
  end
end
