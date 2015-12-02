class CreateSkis < ActiveRecord::Migration
  def change
    create_table :skis do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.integer :price
      t.boolean :poles
      t.boolean :grid
      t.integer :size
      t.text :description
      t.boolean :display
      t.attachment :image

      t.timestamps null: false
    end
  end
end
