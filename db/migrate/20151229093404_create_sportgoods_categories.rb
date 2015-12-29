class CreateSportgoodsCategories < ActiveRecord::Migration
  def change
    create_table :sportgoods_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
