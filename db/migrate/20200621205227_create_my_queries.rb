class CreateMyQueries < ActiveRecord::Migration[5.2]
  def change
    create_view :my_queries
  end
end
