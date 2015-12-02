class AddColumnsToKidsbikes < ActiveRecord::Migration
  def change
    add_column :kidsbikes, :kid_height, :integer
    add_column :kidsbikes, :wheels_material, :string
    add_column :kidsbikes, :sloping_backrest, :boolean
  end
end
