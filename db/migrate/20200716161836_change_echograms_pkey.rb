class ChangeEchogramsPkey < ActiveRecord::Migration[5.2]
  def change
  end

  def up
    execute "ALTER TABLE echograms DROP CONSTRAINT echograms_pkey"   
  end
end
