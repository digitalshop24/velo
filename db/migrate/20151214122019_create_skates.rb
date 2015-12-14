class CreateSkates < ActiveRecord::Migration
  def change
    create_table :skates do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.integer :price
      t.text :description
      t.boolean :display
      t.attachment :image
      t.boolean :hit

      t.timestamps null: false
    end
  end
end
