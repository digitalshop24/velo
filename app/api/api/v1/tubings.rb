module API
  module Entities
    class TubingPreview < ProductEntity
      expose :id
      expose :manufacturer do |tubing|
        tubing.manufacturer.name
      end
      expose :name
      expose :price
      expose :image
    end
    class Tubing < ProductEntity
      expose :id
      expose :manufacturer do |tubing|
        tubing.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image
        expose :price
        expose :description

        expose :bottom_material
        expose :top_material
        expose :diameter
        expose :handles_type
        expose :tow_rope
      end

      expose :similar, using: API::Entities::TubingPreview do |tubing|
        tubing.similar()
      end

      expose :gallery do |tubing|
        if tubing.gallery
          tubing.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Tubings < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :tubings do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all tubings"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Tubing.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::TubingPreview
          # present Tubing.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::TubingPreview
        end
        desc "Return tubing with id"
        get "/:id" do
          present Tubing.find(params[:id]), with: API::Entities::Tubing
        end
      end
    end
  end
end
