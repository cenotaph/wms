class CreateGenres < ActiveRecord::Migration[5.1]
  def self.up
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
    Genre.create(name: 'Balkan accordion')
    Genre.create(name: 'Bagpipes (Scottish, Croatian, Iberian "gaita" or French)')
    Genre.create(name: 'Celtic harp')
    Genre.create(name: 'Dance')
    Genre.create(name: 'Flute')
    Genre.create(name: '"Galician" strings - violin, viola braguesa, bouzouki or guitar')
    Genre.create(name: 'Guitar (Scottish / Irish)')
    Genre.create(name: 'Oriental flutes')
    Genre.create(name: 'Percussion (Irish/Scottish, Chinese, African or Fado tambourine)')
    Genre.create(name: 'Piano')
    Genre.create(name: 'Saxophone (Jazz / traditional)')
    Genre.create(name: 'Singing (Fado, Finnish Bhangra or Finnish traditional)')
    Genre.create(name: 'South American Folk (piano, singing)')
    Genre.create(name: 'Tabla (Indian classical)')
    Genre.create(name: 'Uileann pipes')
  
  end
  
  def self.down
    drop_table :genres
  end
  
end
