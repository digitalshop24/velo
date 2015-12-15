module API
  module Entities
    class ProductEntity < Grape::Entity
      def to_s_ru(value)
        case value.class.to_s
        when 'TrueClass', 'FalseClass'
          value ? 'да' : 'нет'
        else
          value.to_s.empty? ? 'нет данных' : value
        end        
      end
      expose :hit
    end
  end
end
