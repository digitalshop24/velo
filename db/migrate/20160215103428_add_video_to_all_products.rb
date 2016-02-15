class AddVideoToAllProducts < ActiveRecord::Migration
  def change
    add_column :bikes, :video, :string
    add_column :kidsbikes, :video, :string
    add_column :kickscooters, :video, :string
    add_column :sleds, :video, :string
    add_column :tubings, :video, :string
    add_column :icesleds, :video, :string
    add_column :snowrolls, :video, :string
    add_column :electriccars, :video, :string
    add_column :skis, :video, :string
    add_column :skates, :video, :string
    add_column :sportgoods, :video, :string
    add_column :trikes, :video, :string
  end
end
