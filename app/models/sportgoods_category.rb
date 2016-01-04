class SportgoodsCategory < ActiveRecord::Base
  has_many :sportgoods
  has_many :sportgoods_subcategories
  has_attached_file :image,
    styles: { thumb: "200x200> "}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
