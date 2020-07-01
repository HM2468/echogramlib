class ModifyDatabase < ActiveRecord::Migration[5.2]
  def change
    remove_column :echograms, :record_date #remove one column a time, no more
    remove_column :species, :french_name
    add_column :compositions, :n_individuals,:integer
    add_column  :species, :image_filename,:string
  end
end
