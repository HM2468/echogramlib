class CreateMyCompositions < ActiveRecord::Migration[5.2]
  def change
    create_view :my_compositions
  end
end
