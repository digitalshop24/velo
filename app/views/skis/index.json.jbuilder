json.array!(@skis) do |ski|
  json.extract! ski, :id, :manufacturer_id, :name, :price, :poles, :grid, :size, :hit, :description, :display, :image
  json.url ski_url(ski, format: :json)
end
