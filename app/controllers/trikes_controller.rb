class TrikesController < ApplicationController
  load_and_authorize_resource
  before_action :set_trike, only: [:show, :edit, :update, :destroy]

  def index
      @trikes = Trike.paginate(page: params[:page])
  end

  def show
  end

  def new
    @trike = Trike.new
  end

  def edit
  end

  def create
    parms = trike_params
    parms[:frame_color] = parms[:frame_color].split(' ') if parms[:frame_color]
    @trike = Trike.new(parms)
    @trike.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'trike').first_or_create.id    
    respond_to do |format|
      if @trike.save
        if params[:images]
          @trike.gallery ||= Gallery.new
          params[:images].each do |image|
            @trike.gallery.images.create(image: image)
          end
          unless @trike.image_file_size
            @trike.update(image: @trike.gallery.images.first.image)
          end
        end

        format.html { redirect_to @trike, notice: 'Trike was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      parms = trike_params
      parms[:frame_color] = parms[:frame_color].split(' ') if parms[:frame_color]
      if @trike.update(parms)
        if params[:images]
          @trike.gallery ||= Gallery.new
          params[:images].each do |image|
            @trike.gallery.images.create(image: image)
          end
          unless @trike.image_file_size
            @trike.update(image: @trike.gallery.images.first.image)
          end
        end
        format.html { redirect_to @trike, notice: 'Trike was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @trike.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/trike", notice: 'Trike was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_trike
    @trike = Trike.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def trike_params
    params.require(:trike).permit(:price, :name, :manufacturer_id, :image, :description, :recommended_age, :use, :weight, :seat, :seat_belts, :handle, :control_handle, :safety_rim, :visor, :music_unit, :frame_material, :folding_frame, :frame_color, :fork, :fork_type, :speeds_number, :rear_derailleur, :shifters, :shifters_type, :front_brake_type, :rear_brake_type, :wheels_number, :wheels_diameter, :front_wheel_diameter, :attached_wheels, :wheels_type, :rear_wheels_stopper, :raincoat, :front_fender, :rear_fender, :chain_protection, :luggage_rack, :rearview_mirror, :horn, :basket, :bag, :flag, :footboard, :light, :pomp, :display, :hit)
  end
end
