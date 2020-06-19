class CreateEchograms < ActiveRecord::Migration[5.2]
  def change
    create_table :echograms do |t|
      t.string :echogramName
      t.date :recordDate
      t.string :recordTime
      t.float :latitude
      t.float :longitude
      t.integer :frequency
      t.integer :user_id

      t.timestamps
    end
  end
end
