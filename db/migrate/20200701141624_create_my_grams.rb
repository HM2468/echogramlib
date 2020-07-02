class CreateMyGrams < ActiveRecord::Migration[5.2]
  def change
    create_view :my_grams
  end
end
