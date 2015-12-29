class SportgoodsCategory < ActiveRecord::Base
  has_many :sportgoods
  has_many :sportgoods_subcategories
end
