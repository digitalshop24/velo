module API
  module Entities
    class BikePreview < ProductEntity
      expose :id
      expose :manufacturer do |bike|
        bike.manufacturer.name
      end
      expose :name
      expose :price
      expose :bike_class
      expose :bike_type
      expose :frame_type
      expose :image
    end
    class Bike < ProductEntity
      expose :id
      expose :name
      expose :manufacturer do |bike|
        bike.manufacturer.name
      end
      expose :image do |bike|
        bike.image.url
      end
      expose :price
      expose :description

      expose :year
      expose :bike_class
      expose :bike_type
      expose :weight
      expose :frame_type
      expose :handlebar
      expose :chain
      expose :fork
      with_options(format_with: :to_s_ru) { expose :pomp }
      expose :rims
      expose :saddle
      with_options(format_with: :to_s_ru) { expose :roga }
      expose :grips
      with_options(format_with: :to_s_ru) { expose :light }
      expose :carriage
      with_options(format_with: :to_s_ru) { expose :basket }
      expose :shifters
      expose :handlebar_type
      with_options(format_with: :to_s_ru) { expose :luggage_rack }
      with_options(format_with: :to_s_ru) { expose :footboard }
      expose :tires
      expose :fork_type
      expose :saddle_type
      expose :frame_color
      with_options(format_with: :to_s_ru) { expose :chain_protection }
      expose :shifters_type
      expose :pedal_type
      expose :handlebar_width
      expose :tires_width
      with_options(format_with: :to_s_ru) { expose :rear_fender }
      expose :grips_model
      with_options(format_with: :to_s_ru) { expose :double_rims }
      expose :wheels_diameter
      expose :rear_brake
      expose :rear_hub
      expose :frame_material
      with_options(format_with: :to_s_ru) { expose :folding_frame }
      with_options(format_with: :to_s_ru) { expose :front_fender }
      expose :front_hub
      expose :front_brake
      expose :crank_system
      expose :amortization_type
      expose :transmission_type
      expose :fork_locking
      expose :rims_material
      expose :pedal_material
      expose :absorber_length
      with_options(format_with: :to_s_ru) { expose :saddle_amortization }
      with_options(format_with: :to_s_ru) { expose :horn }
      with_options(format_with: :to_s_ru) { expose :rear_absorber }
      expose :tread
      expose :fork_rod_diameter
      expose :rear_brake_type
      with_options(format_with: :to_s_ru) { expose :rearview_mirror }
      expose :ratchet
      expose :rear_derailleur
      expose :speeds_number
      expose :front_break_type
      expose :front_derailleur
      expose :brake_disks_diameter
      expose :stars_number_cassette
      expose :stars_number_system
      expose :teeth_number_cassette
      expose :teeth_number_system
      expose :gallery do |bike|
        if bike.gallery
          bike.gallery.images.map(&:image)
        end
      end
      expose :similar, using: API::Entities::BikePreview do |bike|
        bike.similar()
      end
    end
  end
end

module API
  module V1
    class Bikes < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all
      
      resource :bikes do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all bikes"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Bike.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::BikePreview
          # present Bike.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::BikePreview
        end
        desc "Return bike with id"
        get "/:id" do
          present Bike.find(params[:id]), with: API::Entities::Bike
        end
      end
    end
  end
end
