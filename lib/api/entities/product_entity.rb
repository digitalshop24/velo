module API
  module Entities
    class ProductEntity < Grape::Entity
      def to_s_ru(b)
        return b if b.nil?
        b ? 'да' : 'нет'
      end
    end
  end
end
