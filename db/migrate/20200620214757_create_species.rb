class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.string :species_code
      t.string :scientific_name
      t.string :english_name
      t.string :french_name
      t.string :spanish_name

      t.timestamps
    end
  end
end
