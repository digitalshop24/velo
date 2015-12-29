json.array!(@sportgoods_subcategories) do |sportgoods_subcategory|
  json.extract! sportgoods_subcategory, :id, :name
  json.url sportgoods_subcategory_url(sportgoods_subcategory, format: :json)
end
