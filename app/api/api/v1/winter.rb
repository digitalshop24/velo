module API
  module Entities
    class WinterPreview < ProductEntity
      expose :id do |product|
        product.id + (product.class.name == 'Icesled' ? 1000 : 0)
      end
      expose :manufacturer do |product|
        product.manufacturer.name
      end
      expose :name
      expose :price
      expose :image

      expose :type do |product|
        product.class.name.downcase
      end
      expose :length, safe: true
      with_options(format_with: :to_s_ru) { expose :seat_belt, safe: true }
      with_options(format_with: :to_s_ru) { expose :transport_wheel, safe: true }
      with_options(format_with: :to_s_ru) { expose :handle, safe: true }
      expose :recommended_age, safe: true
    end
  end
end

module API
  module V1
    class Winter < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :winter do
        desc "Return all sled and icesleds"
        get do
          present (Sled.preload(:manufacturer, gallery: [:images]) + Icesled.preload(:manufacturer, gallery: [:images])),
            with: API::Entities::WinterPreview
        end
        desc "Return icesled or sled by id"
        get "/:id" do
          id = params[:id].to_i
          if id > 1000
            present Icesled.find(id - 1000), with: API::Entities::Icesled
          else
            present Sled.find(id), with: API::Entities::Sled
          end
        end
      end
    end
  end
end
