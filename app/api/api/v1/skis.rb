module API
  module Entities
    class SkiPreview < ProductPreviewEntity
      expose :id
      expose :manufacturer do |ski|
        ski.manufacturer.name
      end
      expose :name

      expose :image
    end
    class Ski < ProductEntity
      expose :id
      expose :manufacturer do |ski|
        ski.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image

        expose :description

        expose :poles
        expose :grid
        expose :size
      end

      expose :similar, using: API::Entities::SkiPreview do |ski|
        ski.similar()
      end

      expose :gallery do |ski|
        if ski.gallery
          ski.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Skis < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :skis do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all skis"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Ski.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::SkiPreview
          # present Ski.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::SkiPreview
        end
        desc "Return ski with id"
        get "/:id" do
          present Ski.find(params[:id]), with: API::Entities::Ski
        end
      end
    end
  end
end
