class CreateSnowrolls < ActiveRecord::Migration
  def change
    create_table :snowrolls do |t|
      t.references :manufacturer, index: true, foreign_key: true
      t.string :name
      t.attachment :image
      t.text :description
      t.boolean :amortization
      t.string :seat
      t.string :color, array: true, default: '{}'
      t.boolean :display,  default: true
      t.integer :price

      t.timestamps null: false
    end
  end
end
