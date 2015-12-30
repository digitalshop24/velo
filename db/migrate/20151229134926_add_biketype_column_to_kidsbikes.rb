class AddBiketypeColumnToKidsbikes < ActiveRecord::Migration
  def change
    add_column :kidsbikes, :bike_type, :string
  end
end
