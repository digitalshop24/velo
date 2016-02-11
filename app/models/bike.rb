class Bike < ActiveRecord::Base
  include Product
  BIKE_CLASSES = ["горный", "городской", "шоссейный", "комфортный", "гибридный", "круизер", "электровелосипед", "туристический", "тандем", "циклокроссовый", "BMX", "трековый", "шоссейный (триатлон)"]
  BIKE_TYPES = ["мужской", "женский", "подростковый"]
  FRAME_TYPES = ["закрытая", "открытая"]
  belongs_to :manufacturer
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_one :gallery, as: :galleryable, dependent: :destroy
  has_attached_file :image,
    path: "public/system/images/:galleryable_path/:filename",
    url: "/system/images/:galleryable_path/:basename.:extension",
    styles: { preview: "300x300> "}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates :galleryable_path  do |attachment, style|
    "#{attachment.instance.gallery.galleryable_type.downcase}/#{attachment.instance.gallery.galleryable_id}"
  end

  def tips
    Tip.where(category: 'bike').pluck(:key, :value).to_h
  end
end
