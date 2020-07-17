class CreateEchogramTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :echogram_temps do |t|
      t.string :echogram_name
      t.string :image_filename
      t.integer :frequency
      t.integer :haul_id
      t.integer :user_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
