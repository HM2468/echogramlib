class CreateHauls < ActiveRecord::Migration[5.2]
  def change
    create_table :hauls do |t|
      t.string :echogramName
      t.date :fishDate
      t.string :strtFishTime
      t.string :stpFishTime
      t.float :strtFishLat
      t.float :stpFishLat
      t.float :strtFishLong
      t.float :stpFishLong
      t.float :strtFishDepth
      t.float :stpFishDepth
      t.float :bottomDepth
      t.float :fishSpeed

      t.timestamps
    end
  end
end
