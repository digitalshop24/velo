class CreateSportgoodsSubcategories < ActiveRecord::Migration
  def change
    create_table :sportgoods_subcategories do |t|
      t.string :name
      t.references :sportgoods_category

      t.timestamps null: false
    end
  end
end
