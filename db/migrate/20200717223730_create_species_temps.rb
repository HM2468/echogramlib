class CreateSpeciesTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :species_temps do |t|
      t.string :species_code
      t.string :scientific_name
      t.string :english_name
      t.string :image_filename

      t.timestamps
    end
  end
end
