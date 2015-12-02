class AddColumnsToSnowroll < ActiveRecord::Migration
  def change
    add_column :snowrolls, :seats_number, :string
    add_column :snowrolls, :carrying, :integer
  end
end
