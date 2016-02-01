module API
  module Entities
    class ProductPreviewEntity < Grape::Entity

      def to_s_ru(value)
        case value.class.to_s
        when 'TrueClass', 'FalseClass'
          value ? 'да' : 'нет'
        else
          value.to_s.empty? ? 'нет данных' : value
        end
      end
      expose :hit
      expose :price do |obj|
        obj.price_rub
      end
      expose :old_price do |obj|
        obj.old_price_rub
      end
    end
  end
end
