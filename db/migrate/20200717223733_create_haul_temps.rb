class CreateHaulTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :haul_temps do |t|
      t.string :echogram_name
      t.string :strt_fish_time
      t.string :stp_fish_time
      t.date :fish_date
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
