module API
  module Entities
    class Video < Grape::Entity
      expose :id
      expose :code
    end
  end
end

module API
  module V1
    class Videos < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :videos do
        desc "Все видео"
        get do
          present Video.all, with: API::Entities::Video
        end
        desc "Видео по id"
        get "/:id" do
          present Video.find(params[:id]), with: API::Entities::Video
        end
      end
    end
  end
end
