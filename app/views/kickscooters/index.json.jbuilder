json.array!(@kickscooters) do |kickscooter|
  json.extract! kickscooter, :id, :manufacturer_id, :name, :price, :description, :image, :use, :electric_drive, :max_weight, :wheels_number, :wheels_diameter, :wheels_thickness, :wheels_material, :wheels_hardness, :inflatable_wheels, :bearings, :platform_material, :folding, :seat, :amortization, :front_break, :rear_break, :tilt_handle_control, :wheels_luminodiodes, :min_handlebar_height, :max_handlebar_height, :platform_length, :platform_width, :length, :weight, :horn, :basket, :footboard, :belt, :hit, :display
  json.url kickscooter_url(kickscooter, format: :json)
end
