class DeleteColumnsFromSnowrolls < ActiveRecord::Migration
  def change
    remove_column :snowrolls, :amortization
    remove_column :snowrolls, :seat
    remove_column :snowrolls, :color
  end
end
