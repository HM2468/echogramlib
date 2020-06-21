class CreateEchograms < ActiveRecord::Migration[5.2]
  def change
    create_table :echograms do |t|
      t.string :echogram_name
      t.date :record_date
      t.string :record_time
      t.float :latitude
      t.float :longitude
      t.integer :frequency
      t.integer :user_id

      t.timestamps
    end
  end
end
