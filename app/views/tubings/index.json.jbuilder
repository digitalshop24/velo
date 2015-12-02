json.array!(@tubings) do |tubing|
  json.extract! tubing, :id, :name, :manufacturer_id, :bottom_material, :top_material, :diameter, :handles_type, :tow_rope, :hit, :description, :display
  json.url tubing_url(tubing, format: :json)
end
