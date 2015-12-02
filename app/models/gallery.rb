class Gallery < ActiveRecord::Base
  include Product
  belongs_to :galleryable
  has_many :images, dependent: :destroy

  def not_empty?
    self.images.count > 0
  end
end
