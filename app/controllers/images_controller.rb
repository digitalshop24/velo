class ImagesController < ApplicationController
  load_and_authorize_resource
  def destroy
    image = Image.find(params[:image_id])

    if image.destroy
      # format.json { render json: @image, status: :created, location: @image}
      redirect_to "#{request.env["HTTP_REFERER"]}#gallery", status: 303
    end

  end

end
