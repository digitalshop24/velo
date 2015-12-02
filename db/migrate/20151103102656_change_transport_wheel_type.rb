class ChangeTransportWheelType < ActiveRecord::Migration
  def change
    change_column :sleds, :transport_wheel, 'boolean USING CAST(transport_wheel AS boolean)'
  end
end
