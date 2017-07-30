class CreateLegacyteachers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :legacyteachers do |t|
      t.string :name

      t.timestamps
    end
    Legacyteacher.create(name: 'Uros Jedzic (Slovenia)')
    Legacyteacher.create(name: 'Michael Ferrie (Scotland)')
    Legacyteacher.create(name: 'Ryan Murphy (Ireland)')
    Legacyteacher.create(name: 'Pancho Alvarez (Galicia)')
    Legacyteacher.create(name: 'Sakari Kukko (Finland)')
    Legacyteacher.create(name: 'Wang Nie Jing (China)')
    Legacyteacher.create(name: 'Shi Xueyan (China)')
    Legacyteacher.create(name: 'Ding Nan (China)')
    Legacyteacher.create(name: 'Samuel Takyi (Nigeria)')
    Legacyteacher.create(name: 'Joao Guimaraes (Portugal)')
    Legacyteacher.create(name: 'Kiureli Sammallahti (Finland)')
    Legacyteacher.create(name: 'Sara Vidal (Portugal)')
    Legacyteacher.create(name: 'Cheyenne Brown (Alaska)')
    Legacyteacher.create(name: 'Thomas Zoeller (Germany)')
    Legacyteacher.create(name: 'Hardeep Deerhe (Scotland)')
    Legacyteacher.create(name: 'Daniela Heiderich (France)')
    Legacyteacher.create(name: 'Montserrat Fuentes (Mexico)')
    Legacyteacher.create(name: 'E. Rozukait (Lithuania)')
    Legacyteacher.create(name: 'Stanislav Zubtsov (Finland)')
    Legacyteacher.create(name: 'Goncalo Cruz (Portugal)')
    Legacyteacher.create(name: 'Marika Hyvärinen (Finland)')
    Legacyteacher.create(name: 'Pedro Aibeo (Finland)')
    Legacyteacher.create(name: 'Stjepan Veckovic (Croatia)')
  
  end
  
  def self.down
    drop_table :legacyteachers
  end
end
