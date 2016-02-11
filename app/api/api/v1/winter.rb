module API
  module Entities
    class WinterPreview < ProductPreviewEntity
      expose :id do |product|
        product.id + (product.class.name == 'Icesled' ? 1000 : 0)
      end
      expose :manufacturer do |product|
        product.manufacturer.name
      end
      expose :type do |product|
        product.class.name.downcase
      end

      expose :name

      expose :image
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
          present (Sled.preload(:manufacturer, gallery: [:images]).where(display: true) + Icesled.preload(:manufacturer, gallery: [:images]).where(display: true)),
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
