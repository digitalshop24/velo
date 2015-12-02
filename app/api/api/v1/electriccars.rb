module API
  module Entities
    class ElectriccarPreview < ProductEntity
      expose :id
      expose :manufacturer do |electriccar|
        electriccar.manufacturer.name
      end
      expose :name
      expose :price
      expose :work_time
      expose :battery
      expose :max_weight
      expose :image
    end
    class Electriccar < ProductEntity
      expose :id
      expose :manufacturer do |electriccar|
        electriccar.manufacturer.name
      end
      expose :name
      expose :image
      expose :price
      expose :description

      expose :age
      with_options(format_with: :to_s_ru) { expose :remote_control }
      expose :max_speed
      expose :battery
      expose :engine
      expose :work_time
      expose :charging_time
      expose :max_weight
      expose :weight
      expose :sizes
      expose :light
      with_options(format_with: :to_s_ru) { expose :seat_belt }
      with_options(format_with: :to_s_ru) { expose :rearview_mirror }

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
