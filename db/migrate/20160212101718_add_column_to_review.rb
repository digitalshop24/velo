class AddColumnToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :date, :date
  end
end
