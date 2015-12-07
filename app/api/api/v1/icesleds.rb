module API
  module Entities
    class IcesledPreview < ProductEntity
      expose :id
      expose :manufacturer do |icesled|
        icesled.manufacturer.name
      end
      expose :name
      expose :price
      expose :image
    end
    class Icesled < ProductEntity
      expose :id
      expose :manufacturer do |icesled|
        icesled.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image
        expose :price
        expose :description

        expose :material
        expose :handles
        expose :length
      end
      expose :type do |product|
        product.class.name.downcase
      end

      expose :similar, using: API::Entities::IcesledPreview do |icesled|
        icesled.similar()
      end

      expose :gallery do |icesled|
        if icesled.gallery
          icesled.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Icesleds < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :icesleds do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all icesleds"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Icesled.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::IcesledPreview
          # present Icesled.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::IcesledPreview
        end
        desc "Return icesled with id"
        get "/:id" do
          present Icesled.find(params[:id]), with: API::Entities::Icesled
        end
      end
    end
  end
end
