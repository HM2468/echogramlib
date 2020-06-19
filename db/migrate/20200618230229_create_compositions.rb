class CreateCompositions < ActiveRecord::Migration[5.2]
  def change
    create_table :compositions do |t|
      t.string :speciesCode
      t.float :percentage
      t.float :meanLength
      t.string :echogramName

      t.timestamps
    end
  end
end
