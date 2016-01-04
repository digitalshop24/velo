class AddImagesToSportgoodscCategories < ActiveRecord::Migration
  def change
    add_attachment :sportgoods_categories, :image
    add_attachment :sportgoods_subcategories, :image
  end
end
