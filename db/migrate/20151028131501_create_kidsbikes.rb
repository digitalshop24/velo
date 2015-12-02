class CreateKidsbikes < ActiveRecord::Migration
  def change
    create_table :kidsbikes do |t|
      t.string :name
      t.references :manufacturer, index: true, foreign_key: true
      t.attachment :image
      t.integer :price
      t.string :recommended_age
      t.string :use
      t.float :weight
      t.string :seat
      t.boolean :seat_belts
      t.boolean :handle
      t.boolean :control_handle
      t.boolean :safety_rim
      t.boolean :visor
      t.boolean :music_unit
      t.string :frame_material
      t.boolean :folding_frame
      t.string :frame_color, array: true, default: '{}'
      t.string :fork
      t.string :fork_type
      t.integer :speeds_number
      t.string :rear_derailleur
      t.string :shifters
      t.string :shifters_type
      t.string :front_brake_type
      t.string :rear_brake_type
      t.integer :wheels_number
      t.float :wheels_diameter
      t.float :front_wheel_diameter
      t.boolean :attached_wheels
      t.string :wheels_type
      t.boolean :rear_wheels_stopper
      t.boolean :raincoat
      t.boolean :front_fender
      t.boolean :rear_fender
      t.boolean :chain_protection
      t.boolean :luggage_rack
      t.boolean :rearview_mirror
      t.boolean :horn
      t.boolean :basket
      t.boolean :bag
      t.boolean :flag
      t.boolean :footboard
      t.boolean :light
      t.boolean :pomp
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
