module API
  module Entities
    class Review < Grape::Entity
      expose :id
      expose :name
      expose :content
      expose :mark
      expose :date do |review|
        review.date.strftime("%d.%m.%Y")
      end
    end
  end
end

module API
  module Entities
    class ProductEntity < ProductPreviewEntity
      expose :reviews, using: API::Entities::Review do |obj|
        obj.approved_reviews
      end
      expose :video do |product|
        product.code
      end
    end
  end
end

