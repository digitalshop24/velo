class AddRateToManufacturer < ActiveRecord::Migration
  def change
    add_column :manufacturers, :rate, :float
  end
end
