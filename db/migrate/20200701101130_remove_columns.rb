class RemoveColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :echograms, :record_time
    remove_column :species, :spanish_name
  end
end
