class AddOldOnlinerPriceToProducts < ActiveRecord::Migration
  def change
    add_column :bikes, :old_onliner_price, :float
    add_column :kidsbikes, :old_onliner_price, :float
    add_column :kickscooters, :old_onliner_price, :float
    add_column :sleds, :old_onliner_price, :float
    add_column :tubings, :old_onliner_price, :float
    add_column :icesleds, :old_onliner_price, :float
    add_column :snowrolls, :old_onliner_price, :float
    add_column :electriccars, :old_onliner_price, :float
    add_column :skis, :old_onliner_price, :float
    add_column :skates, :old_onliner_price, :float
    add_column :sportgoods, :old_onliner_price, :float
    add_column :trikes, :old_onliner_price, :float
  end
end
