class CreateSleds < ActiveRecord::Migration
  def change
    create_table :sleds do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.attachment :image
      t.integer :price
      t.text :description
      t.integer :runners_width
      t.boolean :seat_belt
      t.string :seat_belt_type
      t.boolean :folding_visor
      t.string :folding_visor_type
      t.boolean :bag
      t.boolean :flicker
      t.boolean :backrest_adjustment
      t.string :color, array: true, default: '{}'
      t.string :transport_wheel
      t.boolean :legs_case
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
