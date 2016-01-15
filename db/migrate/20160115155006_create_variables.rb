class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string :name
      t.integer :value

      t.timestamps null: false
    end
  end
end
