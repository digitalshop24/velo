class PreviewController < ApplicationController
  def set
    if Object.const_get(params[:product_class].capitalize).find(params[:product_id]).
        update(image: Image.find(params[:image_id]).image)
      redirect_to "#{request.env["HTTP_REFERER"]}#gallery", status: 303
    end
  end
end
