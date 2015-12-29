json.array!(@sportgoods_categories) do |sportgoods_category|
  json.extract! sportgoods_category, :id, :name
  json.url sportgoods_category_url(sportgoods_category, format: :json)
end
