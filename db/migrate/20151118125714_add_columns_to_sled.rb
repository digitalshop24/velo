class AddColumnsToSled < ActiveRecord::Migration
  def change
    add_column :sleds, :handle, :boolean
    add_column :sleds, :recommended_age, :string
  end
end
