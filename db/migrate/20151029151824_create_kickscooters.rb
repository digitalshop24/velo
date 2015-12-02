class CreateKickscooters < ActiveRecord::Migration
  def change
    create_table :kickscooters do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.integer :price
      t.text :description
      t.attachment :image
      t.string :use
      t.boolean :electric_drive
      t.integer :max_weight
      t.integer :wheels_number
      t.integer :wheels_diameter
      t.integer :wheels_thickness
      t.string :wheels_material
      t.string :wheels_hardness
      t.boolean :inflatable_wheels
      t.string :bearings
      t.string :platform_material
      t.boolean :folding
      t.boolean :seat
      t.boolean :amortization
      t.boolean :front_break
      t.boolean :rear_break
      t.boolean :tilt_handle_control
      t.boolean :wheels_luminodiodes
      t.integer :min_handlebar_height
      t.integer :max_handlebar_height
      t.integer :platform_length
      t.integer :platform_width
      t.integer :length
      t.float :weight
      t.boolean :horn
      t.boolean :basket
      t.boolean :footboard
      t.boolean :belt
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
