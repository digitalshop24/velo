class ImagesController < ApplicationController
  before_filter :authenticate_user!
  def destroy
    image = Image.find(params[:image_id])

    if image.destroy
      # format.json { render json: @image, status: :created, location: @image}
      redirect_to "#{request.env["HTTP_REFERER"]}#gallery", status: 303
    end

  end

end
