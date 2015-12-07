module Product
  def self.set_preview(obj, image_id)
    obj.update(image: Image.find(image_id).image)
  end
  def similar(*features)
    self.class.where(hit: true).order("RANDOM()").limit(4)
  end
end
