module API
  module V1
    class Trikes < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :trikes do
        params do
          optional :page, type: Integer, desc: "Page"
          optional :number, type: Integer, desc: "Number"
        end
        desc "Return all trikes"
        get do
          offset = (params[:page] - 1) * params[:number] if params[:number] && params[:page]
          limit = params[:number]
          present Kidsbike.preload(:manufacturer, gallery: [:images]).where(display: true).limit(limit).offset(offset), with: API::Entities::KidsbikePreview
          # present Kidsbike.preload(:manufacturer, gallery: [:images]).limit(300), with: API::Entities::KidsbikePreview
        end
        desc "Return trike with id"
        get "/:id" do
          present Kidsbike.find(params[:id]), with: API::Entities::Kidsbike
        end
      end
    end
  end
end
