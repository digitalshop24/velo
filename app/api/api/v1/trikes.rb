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
          optional :per_page, type: Integer, desc: "Number"
        end
        desc "Return all trikes"
        get do
          present Kidsbike.trikes.where(display: true).preload(:manufacturer, gallery: [:images]).paginate(page: params[:page], per_page: params[:per_page]), with: API::Entities::KidsbikePreview
        end
        desc "Return trike with id"
        get "/:id" do
          present Kidsbike.find(params[:id]), with: API::Entities::Kidsbike
        end
      end
    end
  end
end
