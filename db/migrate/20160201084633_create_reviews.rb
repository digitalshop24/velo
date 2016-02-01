class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :email
      t.integer :mark
      t.text :content
      t.boolean :approved
      t.references :reviewable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
