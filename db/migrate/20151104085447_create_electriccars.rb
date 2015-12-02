class CreateElectriccars < ActiveRecord::Migration
  def change
    create_table :electriccars do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.integer :price
      t.string :age
      t.boolean :remote_control
      t.integer :max_speed
      t.string :battery
      t.string :engine
      t.string :work_time
      t.string :charging_time
      t.integer :max_weight
      t.integer :weight
      t.string :sizes
      t.string :light
      t.boolean :seat_belt
      t.boolean :rearview_mirror
      t.text :description
      t.attachment :image
      t.boolean :display

      t.timestamps null: false
    end
  end
end
