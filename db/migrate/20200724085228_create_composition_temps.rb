class CreateCompositionTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :composition_temps do |t|
      t.string :echogram_name
      t.string :species
      t.integer :numbers
      t.float :percentage
      t.float :mean_length

      t.timestamps
    end
  end
end
