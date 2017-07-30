class CreateLanguages < ActiveRecord::Migration[5.1]
  def self.up
    create_table :languages do |t|
      t.string :locale

      t.timestamps
    end
    Language.create(locale: 'en')
    Language.create(locale: 'fi')
    add_column :users, :other_languages, :string
  end
  
  def self.down
    drop_table :languages
  end
end
