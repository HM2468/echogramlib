class CreateHauls < ActiveRecord::Migration[5.2]
  def change
    create_table :hauls do |t|
      t.string :echogram_name
      t.date :fish_date
      t.string :strt_fish_time
      t.string :stp_fish_time
      t.float :strt_fish_lat
      t.float :stp_fish_lat
      t.float :strt_fish_long
      t.float :stp_fish_long
      t.float :strt_fish_depth
      t.float :stp_fish_depth
      t.float :bottom_depth
      t.float :fish_speed

      t.timestamps
    end
  end
end
