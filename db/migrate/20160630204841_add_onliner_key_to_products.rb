class AddOnlinerKeyToProducts < ActiveRecord::Migration
  def change
    add_column :bikes, :onliner_key, :string
    add_column :kidsbikes, :onliner_key, :string
    add_column :kickscooters, :onliner_key, :string
    add_column :sleds, :onliner_key, :string
    add_column :tubings, :onliner_key, :string
    add_column :icesleds, :onliner_key, :string
    add_column :snowrolls, :onliner_key, :string
    add_column :electriccars, :onliner_key, :string
    add_column :skis, :onliner_key, :string
    add_column :skates, :onliner_key, :string
    add_column :sportgoods, :onliner_key, :string
    add_column :trikes, :onliner_key, :string
  end
end
