json.array!(@electriccars) do |electriccar|
  json.extract! electriccar, :id, :manufacturer_id, :name, :price, :age, :remote_control, :max_speed, :battery, :engine, :work_time, :charging_time, :max_weight, :weight, :sizes, :light, :seat_belt, :hit, :rearview_mirror, :description, :image
  json.url electriccar_url(electriccar, format: :json)
end
