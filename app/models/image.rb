class Image < ActiveRecord::Base
  belongs_to :gallery

  has_attached_file :image,
    :processors => [:watermark],
    path: "public/system/images/:galleryable_path/gallery/:filename",
    url: "/system/images/:galleryable_path/gallery/:basename.:extension",
    styles: {      
      original: { geometry: "1500>", watermark_path: "public/images/watermark.jpg" }
    }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates :galleryable_path  do |attachment, style|
    "#{attachment.instance.gallery.galleryable_type.downcase}/#{attachment.instance.gallery.galleryable_id}"
  end

end
