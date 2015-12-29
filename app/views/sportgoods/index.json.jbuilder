json.array!(@sportgoods) do |sportgood|
  json.extract! sportgood, :id, :manufacturer_id
end
