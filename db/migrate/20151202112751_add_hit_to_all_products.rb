class AddHitToAllProducts < ActiveRecord::Migration
  def change
    add_column :bikes, :hit, :boolean
    add_column :kidsbikes, :hit, :boolean
    add_column :kickscooters, :hit, :boolean
    add_column :sleds, :hit, :boolean
    add_column :tubings, :hit, :boolean
    add_column :icesleds, :hit, :boolean
    add_column :snowrolls, :hit, :boolean
    add_column :electriccars, :hit, :boolean
    add_column :skis, :hit, :boolean
  end
end
