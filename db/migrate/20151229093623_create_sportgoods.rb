class CreateSportgoods < ActiveRecord::Migration
  def change
    create_table :sportgoods do |t|
      t.references :sportgoods_category, index: true, foreign_key: true
      t.references :sportgoods_subcategory, index: true, foreign_key: true
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
