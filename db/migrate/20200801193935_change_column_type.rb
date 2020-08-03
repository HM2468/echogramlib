class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :echogram_temps, :longitude, :string
    change_column :echogram_temps, :latitude,  :string
    change_column :composition_temps, :numbers, :string
    change_column :composition_temps, :mean_length, :string
  end
end
