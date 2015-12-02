class CreateIcesleds < ActiveRecord::Migration
  def change
    create_table :icesleds do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.attachment :image
      t.text :description
      t.string :material
      t.boolean :handles
      t.integer :length
      t.boolean :display, default: true
      t.integer :price

      t.timestamps null: false
    end
  end
end
