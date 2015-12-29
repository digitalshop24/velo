module API
  module Entities
    class SportgoodPreview < ProductEntity
      expose :id
      expose :category_id do |sportgood|
        sportgood.sportgoods_category_id
      end
      expose :subcategory_id do |sportgood|
        sportgood.sportgoods_subcategory_id
      end
      expose :manufacturer do |sportgood|
        sportgood.manufacturer.name
      end
      expose :name
      expose :price
      expose :image
    end
    
    class Sportgood < ProductEntity
      expose :id
      expose :category_id do |sportgood|
        sportgood.sportgoods_category_id
      end
      expose :subcategory_id do |sportgood|
        sportgood.sportgoods_subcategory_id
      end
      expose :manufacturer do |sportgood|
        sportgood.manufacturer.name
      end
      expose :name
      expose :price
      expose :image
      expose :similar, using: API::Entities::SportgoodPreview do |sportgood|
        sportgood.similar()
      end

      expose :gallery do |sportgood|
        if sportgood.gallery
          sportgood.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Sportgoods < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :sportgoods do
        desc "Return all sportgoods"
        get do
          present Sportgood.preload(:sportgoods_category, :sportgoods_subcategory, :manufacturer, gallery: [:images]).where(display: true), with: API::Entities::SportgoodPreview
        end
        desc "Return sportgood with id"
        get "/:id" do
          present Sportgood.find(params[:id]), with: API::Entities::Sportgood
        end
        get "/category/:category_id" do
          present Sportgood.
            preload(:sportgoods_category, :sportgoods_subcategory, :manufacturer, gallery: [:images]).
            where(display: true, sportgoods_category_id: params[:category_id]), with: API::Entities::SportgoodPreview
        end
        get "/category/:category_id/:subcategory_id" do
          present Sportgood.
            preload(:sportgoods_category, :sportgoods_subcategory, :manufacturer, gallery: [:images]).
            where(display: true, sportgoods_category_id: params[:category_id], sportgoods_subcategory_id: params[:subcategory_id]), with: API::Entities::SportgoodPreview
        end
      end
    end
  end
end
