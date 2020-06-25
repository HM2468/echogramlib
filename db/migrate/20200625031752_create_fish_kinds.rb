class CreateFishKinds < ActiveRecord::Migration[5.2]
  def change
    create_view :fish_kinds
  end
end
