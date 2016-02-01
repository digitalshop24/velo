module API
  module Entities
    class KickscooterPreview < ProductPreviewEntity
      expose :id
      expose :manufacturer do |kickscooter|
        kickscooter.manufacturer.name
      end
      expose :name

      expose :image
    end
    class Kickscooter < ProductEntity
      expose :id
      expose :manufacturer do |kickscooter|
        kickscooter.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image

        expose :description

        expose :use
        expose :electric_drive
        expose :max_weight
        expose :wheels_number
        expose :wheels_diameter
        expose :wheels_thickness
        expose :wheels_material
        expose :wheels_hardness
        expose :inflatable_wheels
        expose :bearings
        expose :platform_material
        expose :folding
        expose :seat
        expose :amortization
        expose :front_break
        expose :rear_break
        expose :tilt_handle_control
        expose :wheels_luminodiodes
        expose :min_handlebar_height
        expose :max_handlebar_height
        expose :platform_length
        expose :platform_width
        expose :length
        expose :weight
        expose :horn
        expose :basket
        expose :footboard
        expose :belt
        expose :description
      end
      expose :gallery do |kickscooter|
        if kickscooter.gallery
          kickscooter.gallery.images.map(&:image)
        end
      end
      expose :similar, using: API::Entities::KickscooterPreview do |kickscooter|
        kickscooter.similar(:wheels_number, :electric_drive, :use)
      end
    end
  end
end


module API
  module V1
    class Kickscooters < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :kickscooters do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all kickscooters"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Kickscooter.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::KickscooterPreview
          # present Kickscooter.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::KickscooterPreview
        end
        desc "Return kickscooter with id"
        get "/:id" do
          present Kickscooter.find(params[:id]), with: API::Entities::Kickscooter
        end
      end
    end
  end
end
