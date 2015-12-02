json.array!(@sleds) do |sled|
  json.extract! sled, :id, :manufacturer_id, :name, :image, :description, :runners_width, :seat_belt, :seat_belt_type, :folding_visor, :folding_visor_type, :bag, :flicker, :backrest_adjustment, :color, :transport_wheel, :hit, :legs_case, :display
  json.url sled_url(sled, format: :json)
end
