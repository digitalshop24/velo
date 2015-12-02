json.array!(@snowrolls) do |snowroll|
  json.extract! snowroll, :id, :manufacturer_id, :name, :image, :description, :amortization, :seat, :color, :hit, :display
  json.url snowroll_url(snowroll, format: :json)
end
