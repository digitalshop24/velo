json.array!(@skates) do |skate|
  json.extract! skate, :id, :manufacturer_id, :name, :price, :text, :display, :image, :hit
  json.url skate_url(skate, format: :json)
end
