class AddOnlinerPricesToProducts < ActiveRecord::Migration
  def change
    add_column :bikes, :onliner_price, :float
    add_column :kidsbikes, :onliner_price, :float
    add_column :kickscooters, :onliner_price, :float
    add_column :sleds, :onliner_price, :float
    add_column :tubings, :onliner_price, :float
    add_column :icesleds, :onliner_price, :float
    add_column :snowrolls, :onliner_price, :float
    add_column :electriccars, :onliner_price, :float
    add_column :skis, :onliner_price, :float
    add_column :skates, :onliner_price, :float
    add_column :sportgoods, :onliner_price, :float
    add_column :trikes, :onliner_price, :float
  end
end
