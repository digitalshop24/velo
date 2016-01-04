module API
  module Entities
    class SportgoodsSubcategory < Grape::Entity
      expose :id
      expose :name
      expose :image do |subcategory|
        subcategory.image.url(:thumb)
      end
    end
    class SportgoodsCategory < Grape::Entity
      expose :id
      expose :name
      expose :image do |category|
        category.image.url(:thumb)
      end
      expose :sportgoods_subcategories, using: API::Entities::SportgoodsSubcategory
    end
  end
end


module API
  module V1
    class SportgoodsCategories < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :sportgoods_categories do
        desc "Return all sportgoods categories"
        get do
          present SportgoodsCategory.preload(:sportgoods_subcategories), with: API::Entities::SportgoodsCategory
        end
      end
    end
  end
end
