module API
  module Entities
    class SledPreview < ProductPreviewEntity
      expose :id
      expose :manufacturer do |sled|
        sled.manufacturer.name
      end
      expose :name

      expose :image
    end
    class Sled < ProductEntity
      expose :id
      expose :manufacturer do |sled|
        sled.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image

        expose :description

        expose :recommended_age
        expose :runners_width
        expose :seat_belt
        expose :transport_wheel
        expose :handle
        expose :seat_belt_type
        expose :folding_visor
        expose :folding_visor_type
        expose :bag
        expose :flicker
        expose :backrest_adjustment
        expose :color do |a|
          a.color.join(' ')
        end
        expose :legs_case
      end
      expose :type do |product|
        product.class.name.downcase
      end

      expose :similar, using: API::Entities::SledPreview do |sled|
        sled.similar()
      end

      expose :gallery do |sled|
        if sled.gallery
          sled.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Sleds < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :sleds do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all sleds"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Sled.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::SledPreview
          # present Sled.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::SledPreview
        end
        desc "Return sled with id"
        get "/:id" do
          present Sled.find(params[:id]), with: API::Entities::Sled
        end
      end
    end
  end
end
