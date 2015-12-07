class KidsbikesController < ApplicationController
  load_and_authorize_resource
  before_action :set_kidsbike, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category] == 'trike'
      @kidsbikes = Kidsbike.joins(:manufacturer).where("manufacturers.category = 'trike'").paginate(:page => params[:page])
    else
      @kidsbikes = Kidsbike.preload(:manufacturer).paginate(:page => params[:page])
    end
  end

  def show
  end

  def new
    @kidsbike = Kidsbike.new
  end

  def edit
  end

  def create
    parms = kidsbike_params
    parms[:frame_color] = parms[:frame_color].split(', ') if parms[:frame_color]
    @kidsbike = Kidsbike.new(parms)
    @kidsbike.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'kidsbike').first_or_create.id    
    respond_to do |format|
      if @kidsbike.save
        if params[:images]
          @kidsbike.gallery ||= Gallery.new
          params[:images].each do |image|
            @kidsbike.gallery.images.create(image: image)
          end
          unless @kidsbike.image_file_size
            @kidsbike.update(image: @kidsbike.gallery.images.first.image)
          end
        end

        format.html { redirect_to @kidsbike, notice: 'Kidsbike was successfully created.' }
        format.json { render :show, status: :created, location: @kidsbike }
      else
        format.html { render :new }
        format.json { render json: @kidsbike.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      parms = kidsbike_params
      parms[:frame_color] = parms[:frame_color].split(' ') if parms[:frame_color]
      if @kidsbike.update(parms)
        if params[:images]
          @kidsbike.gallery ||= Gallery.new
          params[:images].each do |image|
            @kidsbike.gallery.images.create(image: image)
          end
          unless @kidsbike.image_file_size
            @kidsbike.update(image: @kidsbike.gallery.images.first.image)
          end
        end
        format.html { redirect_to @kidsbike, notice: 'Kidsbike was successfully updated.' }
        format.json { render :show, status: :ok, location: @kidsbike }
      else
        format.html { render :edit }
        format.json { render json: @kidsbike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @kidsbike.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/kidsbike", notice: 'Kidsbike was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_kidsbike
    @kidsbike = Kidsbike.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def kidsbike_params
    params.require(:kidsbike).permit(:price, :name, :manufacturer_id, :image, :description, :recommended_age, :use, :weight, :seat, :seat_belts, :handle, :control_handle, :safety_rim, :visor, :music_unit, :frame_material, :folding_frame, :frame_color, :fork, :fork_type, :speeds_number, :rear_derailleur, :shifters, :shifters_type, :front_brake_type, :rear_brake_type, :wheels_number, :wheels_diameter, :front_wheel_diameter, :attached_wheels, :wheels_type, :rear_wheels_stopper, :raincoat, :front_fender, :rear_fender, :chain_protection, :luggage_rack, :rearview_mirror, :horn, :basket, :bag, :flag, :footboard, :light, :pomp, :display, :hit)
  end
end
