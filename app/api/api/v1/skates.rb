module API
  module Entities
    class SkatePreview < ProductPreviewEntity
      expose :id
      expose :manufacturer do |skate|
        skate.manufacturer.name
      end
      expose :name

      expose :image
    end
    class Skate < ProductEntity
      expose :id
      expose :manufacturer do |skate|
        skate.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image

        expose :description
      end

      expose :similar, using: API::Entities::SkatePreview do |skate|
        skate.similar()
      end

      expose :gallery do |skate|
        if skate.gallery
          skate.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Skates < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :skates do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all skates"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Skate.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::SkatePreview
          # present Skate.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::SkatePreview
        end
        desc "Return skate with id"
        get "/:id" do
          present Skate.find(params[:id]), with: API::Entities::Skate
        end
      end
    end
  end
end
