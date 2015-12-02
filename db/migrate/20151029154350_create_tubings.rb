class CreateTubings < ActiveRecord::Migration
  def change
    create_table :tubings do |t|
      t.string :name
      t.references :manufacturer, index: true, foreign_key: true
      t.string :bottom_material
      t.string :top_material
      t.integer :diameter
      t.string :handles_type
      t.boolean :tow_rope
      t.text :description
      t.boolean :display, default: true
      t.integer :price
      t.attachment :image

      t.timestamps null: false
    end
  end
end
