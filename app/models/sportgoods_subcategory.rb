class SportgoodsSubcategory < ActiveRecord::Base
  has_many :sportgoods
  belongs_to :sportgoods_category
  has_attached_file :image,
    styles: { thumb: "200x200> "}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
