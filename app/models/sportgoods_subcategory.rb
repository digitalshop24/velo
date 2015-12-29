class SportgoodsSubcategory < ActiveRecord::Base
  has_many :sportgoods
  belongs_to :sportgodds_category
end
