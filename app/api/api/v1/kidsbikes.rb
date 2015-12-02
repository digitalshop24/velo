module API
  module Entities
    class KidsbikePreview < ProductEntity
      expose :id
      expose :manufacturer do |kidsbike|
        kidsbike.manufacturer.name
      end
      expose :name
      expose :price
      expose :image
      expose :bike_type do |kidsbike|
        if (kidsbike.wheels_number == 3)
          "трайк"
        else
          "детский"
        end
      end
      expose :wheels_diameter
      expose :kid_height
      expose :recommended_age
      expose :wheels_material
      with_options(format_with: :to_s_ru) { expose :light }
      with_options(format_with: :to_s_ru) { expose :sloping_backrest }
    end
    class Kidsbike < ProductEntity
      expose :id
      expose :manufacturer do |kidsbike|
        kidsbike.manufacturer.name
      end
      expose :name
      expose :image
      expose :price
      expose :description

      expose :recommended_age
      expose :kid_height
      expose :wheels_material
      with_options(format_with: :to_s_ru) { expose :sloping_backrest }
      expose :use
      expose :weight
      expose :seat
      with_options(format_with: :to_s_ru) { expose :seat_belts }
      with_options(format_with: :to_s_ru) { expose :handle }
      with_options(format_with: :to_s_ru) { expose :control_handle }
      with_options(format_with: :to_s_ru) { expose :safety_rim }
      with_options(format_with: :to_s_ru) { expose :visor }
      with_options(format_with: :to_s_ru) { expose :music_unit }
      expose :frame_material
      with_options(format_with: :to_s_ru) { expose :folding_frame }
      expose :frame_color
      expose :fork
      expose :fork_type
      expose :speeds_number
      expose :rear_derailleur
      expose :shifters
      expose :shifters_type
      expose :front_brake_type
      expose :rear_brake_type
      expose :wheels_number
      expose :wheels_diameter
      expose :front_wheel_diameter
      expose :attached_wheels
      expose :wheels_type
      with_options(format_with: :to_s_ru) { expose :rear_wheels_stopper }
      with_options(format_with: :to_s_ru) { expose :raincoat }
      with_options(format_with: :to_s_ru) { expose :front_fender }
      with_options(format_with: :to_s_ru) { expose :rear_fender }
      with_options(format_with: :to_s_ru) { expose :chain_protection }
      with_options(format_with: :to_s_ru) { expose :luggage_rack }
      with_options(format_with: :to_s_ru) { expose :rearview_mirror }
      with_options(format_with: :to_s_ru) { expose :horn }
      with_options(format_with: :to_s_ru) { expose :basket }
      with_options(format_with: :to_s_ru) { expose :bag }
      with_options(format_with: :to_s_ru) { expose :flag }
      with_options(format_with: :to_s_ru) { expose :footboard }
      with_options(format_with: :to_s_ru) { expose :light }
      with_options(format_with: :to_s_ru) { expose :pomp }
      expose :bike_class do |kidsbike|
        "детский"
      end
      expose :similar, using: API::Entities::KidsbikePreview do |kidsbike|
        kidsbike.similar()
      end
      expose :gallery do |kidsbike|
        if kidsbike.gallery
          kidsbike.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Kidsbikes < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :kidsbikes do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all kidsbikes"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Kidsbike.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::KidsbikePreview
          # present Kidsbike.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::KidsbikePreview
        end
        desc "Return kidsbike with id"
        get "/:id" do
          present Kidsbike.find(params[:id]), with: API::Entities::Kidsbike
        end
      end
    end
  end
end
