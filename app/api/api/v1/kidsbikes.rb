module API
  module Entities
    class KidsbikePreview < ProductEntity
      expose :id
      expose :manufacturer do |kidsbike|
        kidsbike.manufacturer.name
      end
      expose :name
      expose :price do |obj|
        obj.price_rub
      end
      expose :image
      expose :bike_type
    end
    class Kidsbike < ProductEntity
      expose :id
      expose :manufacturer do |kidsbike|
        kidsbike.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image
        expose :price do |obj|
          obj.price_rub
        end
        expose :description

        expose :recommended_age
        expose :kid_height
        expose :wheels_material
        expose :sloping_backrest
        expose :use
        expose :weight
        expose :seat
        expose :seat_belts
        expose :handle
        expose :control_handle
        expose :safety_rim
        expose :visor
        expose :music_unit
        expose :frame_material
        expose :folding_frame
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
        expose :rear_wheels_stopper
        expose :raincoat
        expose :front_fender
        expose :rear_fender
        expose :chain_protection
        expose :luggage_rack
        expose :rearview_mirror
        expose :horn
        expose :basket
        expose :bag
        expose :flag
        expose :footboard
        expose :light
        expose :pomp
      end
      expose :bike_class do |kidsbike|
        "детский"
      end
      expose :similar, using: API::Entities::KidsbikePreview do |kidsbike|
        kidsbike.similar(:wheels_number, :use)
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
          optional :per_page, type: Integer, desc: "Number"
        end
        desc "Return all kidsbikes"
        get do
          present Kidsbike.kidsbikes.where(display: true).preload(:manufacturer, gallery: [:images]).paginate(page: params[:page], per_page: params[:per_page]), with: API::Entities::KidsbikePreview
        end
        desc "Return kidsbike with id"
        get "/:id" do
          present Kidsbike.find(params[:id]), with: API::Entities::Kidsbike
        end
      end
    end
  end
end
