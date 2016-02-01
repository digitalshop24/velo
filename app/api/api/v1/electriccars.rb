module API
  module Entities
    class ElectriccarPreview < ProductPreviewEntity
      expose :id
      expose :manufacturer do |electriccar|
        electriccar.manufacturer.name
      end
      expose :name

      expose :image
    end
    class Electriccar < ProductEntity
      expose :id
      expose :manufacturer do |electriccar|
        electriccar.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image

        expose :description

        expose :age
        expose :remote_control
        expose :max_speed
        expose :battery
        expose :engine
        expose :work_time
        expose :charging_time
        expose :max_weight
        expose :weight
        expose :sizes
        expose :light
        expose :seat_belt
        expose :rearview_mirror
      end

      expose :similar, using: API::Entities::ElectriccarPreview do |electriccar|
        electriccar.similar()
      end

      expose :gallery do |electriccar|
        if electriccar.gallery
          electriccar.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Electriccars < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :electriccars do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all electriccars"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Electriccar.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::ElectriccarPreview
          # present Electriccar.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::ElectriccarPreview
        end
        desc "Return electriccar with id"
        get "/:id" do
          present Electriccar.find(params[:id]), with: API::Entities::Electriccar
        end
      end
    end
  end
end
