class AddColumnToKidsbikes < ActiveRecord::Migration
  def change
    add_column :kidsbikes, :description, :text
  end
end
