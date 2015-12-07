module API
  module Entities
    class SnowrollPreview < ProductEntity
      expose :id
      expose :manufacturer do |snowroll|
        snowroll.manufacturer.name
      end
      expose :name
      expose :price
      expose :image
    end
    class Snowroll < ProductEntity
      expose :id
      expose :manufacturer do |snowroll|
        snowroll.manufacturer.name
      end
      with_options(format_with: :to_s_ru) do
        expose :name
        expose :image
        expose :price
        expose :description

        expose :seats_number
        expose :carrying
      end

      expose :similar, using: API::Entities::SnowrollPreview do |snowroll|
        snowroll.similar(:seats_number)
      end

      expose :gallery do |snowroll|
        if snowroll.gallery
          snowroll.gallery.images.map(&:image)
        end
      end
    end
  end
end


module API
  module V1
    class Snowrolls < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :snowrolls do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all snowrolls"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Snowroll.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::SnowrollPreview
          # present Snowroll.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::SnowrollPreview
        end
        desc "Return snowroll with id"
        get "/:id" do
          present Snowroll.find(params[:id]), with: API::Entities::Snowroll
        end
      end
    end
  end
end
