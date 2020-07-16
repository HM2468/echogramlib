class ModifyEchogram < ActiveRecord::Migration[5.2]
  def change
    add_column  :echograms, :haul_id,:integer
    add_column  :echograms, :image_filename,:string
  end
end
