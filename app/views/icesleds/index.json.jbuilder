json.array!(@icesleds) do |icesled|
  json.extract! icesled, :id, :manufacturer_id, :name, :image, :description, :material, :handles, :length, :hit, :display
  json.url icesled_url(icesled, format: :json)
end
