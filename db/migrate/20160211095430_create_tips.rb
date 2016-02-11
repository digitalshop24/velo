class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :category
      t.string :key
      t.string :value

      t.timestamps null: false
    end
  end
end
