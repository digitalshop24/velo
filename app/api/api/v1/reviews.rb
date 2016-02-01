module API
  module V1
    class Reviews < Grape::API
      version 'v1'
      format :json
      content_type :json, "application/json;charset=UTF-8"
      rescue_from :all

      resource :reviews do
        params do
          requires :name, type: String
          requires :email, type: String
          requires :content, type: String
          requires :mark, type: Integer
          requires :reviewable_type, type: String
          requires :reviewable_id, type: Integer
        end
        post do
          parms = params
          parms[:reviewable_type] = parms[:reviewable_type].capitalize
          parms = ActionController::Parameters.new(parms).permit(:name, :email, :mark, :content, :reviewable_id, :reviewable_type)
          Review.create(parms)
        end
      end
    end
  end
end
