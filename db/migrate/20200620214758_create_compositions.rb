class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.string :species_code
      t.float :percentage
      t.float :mean_length
      t.string :echogram_name

      t.timestamps
    end
  end
end
