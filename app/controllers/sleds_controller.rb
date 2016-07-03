class SledsController < ApplicationController
  load_and_authorize_resource
  before_action :set_sled, only: [:show, :edit, :update, :destroy]

  # GET /sleds/1
  # GET /sleds/1.json
  def show
  end

  # GET /sleds/new
  def new
    @sled = Sled.new
  end

  # GET /sleds/1/edit
  def edit
  end

  # POST /sleds
  # POST /sleds.json
  def create
    parms = sled_params
    parms[:color] = parms[:color].split(', ') if parms[:color]
    @sled = Sled.new(parms)
    @sled.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'sled').first_or_create.id
    respond_to do |format|
      if @sled.save
        if params[:images]
          @sled.gallery ||= Gallery.new
          params[:images].each do |image|
            @sled.gallery.images.create(image: image)
          end
          unless @sled.image_file_size
            @sled.update(image: @sled.gallery.images.first.image)
          end
        end
        format.html { redirect_to @sled, notice: 'Sled was successfully created.' }
        format.json { render :show, status: :created, location: @sled }
      else
        format.html { render :new }
        format.json { render json: @sled.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sleds/1
  # PATCH/PUT /sleds/1.json
  def update
    parms = sled_params
    parms[:color] = parms[:color].split(', ') if parms[:color]
    respond_to do |format|
      if @sled.update(parms)
        if params[:images]
          @sled.gallery ||= Gallery.new
          params[:images].each do |image|
            @sled.gallery.images.create(image: image)
          end
          unless @sled.image_file_size
            @sled.update(image: @sled.gallery.images.first.image)
          end
        end
        format.html { redirect_to @sled, notice: 'Sled was successfully updated.' }
        format.json { render :show, status: :ok, location: @sled }
      else
        format.html { render :edit }
        format.json { render json: @sled.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sleds/1
  # DELETE /sleds/1.json
  def destroy
    @sled.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/sled", notice: 'Sled was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sled
    @sled = Sled.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sled_params
    params.require(:sled).permit(:video, :handle, :recommended_age, :price, :old_price, :manufacturer_id, :name, :image, :description, :runners_width, :seat_belt, :seat_belt_type, :folding_visor, :folding_visor_type, :bag, :flicker, :backrest_adjustment, :color, :transport_wheel, :legs_case, :display, :hit)
  end
end
