module API
  module Entities
    class KickscooterPreview < ProductEntity
      expose :id
      expose :manufacturer do |kickscooter|
        kickscooter.manufacturer.name
      end
      expose :name
      expose :price
      expose :wheels_number
      expose :max_weight
      expose :image
    end
    class Kickscooter < ProductEntity
      expose :id
      expose :manufacturer do |kickscooter|
        kickscooter.manufacturer.name
      end
      expose :name
      expose :image
      expose :price
      expose :description

      expose :use
      with_options(format_with: :to_s_ru) { expose :electric_drive }
      expose :max_weight
      expose :wheels_number
      expose :wheels_diameter
      expose :wheels_thickness
      expose :wheels_material
      expose :wheels_hardness
      with_options(format_with: :to_s_ru) { expose :inflatable_wheels }
      expose :bearings
      expose :platform_material
      with_options(format_with: :to_s_ru) { expose :folding }
      with_options(format_with: :to_s_ru) { expose :seat }
      with_options(format_with: :to_s_ru) { expose :amortization }
      with_options(format_with: :to_s_ru) { expose :front_break }
      with_options(format_with: :to_s_ru) { expose :rear_break }
      with_options(format_with: :to_s_ru) { expose :tilt_handle_control }
      with_options(format_with: :to_s_ru) { expose :wheels_luminodiodes }
      expose :min_handlebar_height
      expose :max_handlebar_height
      expose :platform_length
      expose :platform_width
      expose :length
      expose :weight
      with_options(format_with: :to_s_ru) { expose :horn }
      with_options(format_with: :to_s_ru) { expose :basket }
      with_options(format_with: :to_s_ru) { expose :footboard }
      with_options(format_with: :to_s_ru) { expose :belt }
      expose :description
      expose :gallery do |kickscooter|
        if kickscooter.gallery
          kickscooter.gallery.images.map(&:image)
        end
      end
      expose :similar, using: API::Entities::KickscooterPreview do |kickscooter|
        kickscooter.similar()
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
