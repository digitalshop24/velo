module Product
  def self.set_preview(obj, image_id)
    obj.update(image: Image.find(image_id).image)
  end
  def similar(*features)
    self.class.where(hit: true, display: true).order("RANDOM()").limit(4)
  end
  def price_rub
    rate = manufacturer.rate.to_i == 0 ? Variable.rate.value : manufacturer.rate
    (price * rate / 5000).ceil.to_i * 5000 if price
  end
  def old_price_rub
    rate = manufacturer.rate.to_i == 0 ? Variable.rate.value : manufacturer.rate
    (old_price * rate / 5000).ceil.to_i * 5000 if old_price
  end
  def approved_reviews
    reviews.where(approved: true)
  end
  SIZES = {width: 444, height: 250}
  def embed
    "<iframe width=\"#{SIZES[:width]}\" height=\"#{SIZES[:height]}\" src=\"https://www.youtube.com/embed/#{code}\" frameborder=\"0\" allowfullscreen></iframe>"
  end
  def code
    video.split('/').last() if video
  end
end
