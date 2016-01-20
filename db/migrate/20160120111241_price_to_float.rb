class PriceToFloat < ActiveRecord::Migration
  def change
    change_column :bikes, :price, :float
    change_column :kidsbikes, :price, :float
    change_column :kickscooters, :price, :float
    change_column :sleds, :price, :float
    change_column :tubings, :price, :float
    change_column :icesleds, :price, :float
    change_column :snowrolls, :price, :float
    change_column :electriccars, :price, :float
    change_column :skis, :price, :float
    change_column :skates, :price, :float
    change_column :sportgoods, :price, :float
  end
end
