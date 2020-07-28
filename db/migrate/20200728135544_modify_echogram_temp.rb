class ModifyEchogramTemp < ActiveRecord::Migration[5.2]
  def change
      add_column  :echogram_temps, :editable,:boolean
  end
end

