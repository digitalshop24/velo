module API
  module V1
    class Root < Grape::API
      mount API::V1::Bikes
      mount API::V1::Kidsbikes
      mount API::V1::Trikes
      mount API::V1::Kickscooters
      mount API::V1::Sleds
      mount API::V1::Icesleds
      mount API::V1::Snowrolls
      mount API::V1::Tubings
      mount API::V1::Electriccars
      mount API::V1::Skis
      mount API::V1::Skates
      mount API::V1::Sportgoods
      mount API::V1::SportgoodsCategories
      mount API::V1::Reviews

      mount API::V1::Winter
    end
  end
end
