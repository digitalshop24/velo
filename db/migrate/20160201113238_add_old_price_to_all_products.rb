class AddOldPriceToAllProducts < ActiveRecord::Migration
  def change
    add_column :bikes, :old_price, :float
    add_column :kidsbikes, :old_price, :float
    add_column :kickscooters, :old_price, :float
    add_column :sleds, :old_price, :float
    add_column :tubings, :old_price, :float
    add_column :icesleds, :old_price, :float
    add_column :snowrolls, :old_price, :float
    add_column :electriccars, :old_price, :float
    add_column :skis, :old_price, :float
    add_column :skates, :old_price, :float
    add_column :sportgoods, :old_price, :float
    add_column :trikes, :old_price, :float
  end
end
