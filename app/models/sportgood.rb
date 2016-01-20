class Sportgood < ActiveRecord::Base
  include Product
  belongs_to :sportgoods_category
  belongs_to :sportgoods_subcategory
  belongs_to :manufacturer

  has_one :gallery, as: :galleryable, dependent: :destroy
  has_attached_file :image,
    path: "public/system/images/:galleryable_path/:filename",
    url: "/system/images/:galleryable_path/:basename.:extension",
    styles: { preview: "300x300> "}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates :galleryable_path  do |attachment, style|
    "#{attachment.instance.gallery.galleryable_type.downcase}/#{attachment.instance.gallery.galleryable_id}"
  end

  def sportgoods_category_name
    sportgoods_category.name if sportgoods_category
  end
  def sportgoods_subcategory_name
    sportgoods_subcategory.name if sportgoods_subcategory
  end
end
