class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.attachment :image
      t.integer :price
      t.integer :year
      t.string :bike_class
      t.string :bike_type
      t.float :weight
      t.text :description
      t.string :frame_type
      t.string :handlebar
      t.string :chain
      t.string :fork
      t.boolean :pomp
      t.string :rims
      t.string :saddle
      t.boolean :roga
      t.string :grips
      t.boolean :light
      t.string :carriage
      t.boolean :basket
      t.string :shifters
      t.string :handlebar_type
      t.boolean :luggage_rack
      t.boolean :footboard
      t.string :tires
      t.string :fork_type
      t.string :saddle_type
      t.string :frame_color, array: true, default: '{}'
      t.boolean :chain_protection
      t.string :shifters_type
      t.string :pedal_type
      t.float :handlebar_width
      t.float :tires_width
      t.boolean :rear_fender
      t.string :grips_model
      t.boolean :double_rims
      t.float :wheels_diameter
      t.string :rear_brake
      t.string :rear_hub
      t.string :frame_material
      t.boolean :folding_frame
      t.boolean :front_fender
      t.string :front_hub
      t.string :front_brake
      t.string :crank_system
      t.string :amortization_type
      t.string :transmission_type
      t.boolean :fork_locking
      t.string :rims_material
      t.string :pedal_material
      t.string :absorber_length
      t.boolean :saddle_amortization
      t.boolean :horn
      t.boolean :rear_absorber
      t.string :tread
      t.float :fork_rod_diameter
      t.string :rear_brake_type
      t.boolean :rearview_mirror
      t.string :ratchet
      t.string :rear_derailleur
      t.integer :speeds_number
      t.string :front_break_type
      t.string :front_derailleur
      t.float :brake_disks_diameter
      t.integer :stars_number_cassette
      t.integer :stars_number_system
      t.integer :teeth_number_cassette
      t.integer :teeth_number_system
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
