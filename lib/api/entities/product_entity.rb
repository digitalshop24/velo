module API
  module Entities
    class Review < Grape::Entity
      expose :id
      expose :name
      expose :email
      expose :content
      expose :mark
    end
  end
end

module API
  module Entities
    class ProductEntity < ProductPreviewEntity
      expose :reviews, using: API::Entities::Review do |obj|
        obj.approved_reviews
      end
    end
  end
end

