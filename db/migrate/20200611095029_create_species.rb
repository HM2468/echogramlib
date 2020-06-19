class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.string :speciesCode
      t.string :scientificName
      t.string :englishName
      t.string :frenchName
      t.string :spanishName

      t.timestamps
    end
  end
end
