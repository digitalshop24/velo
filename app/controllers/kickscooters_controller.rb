class KickscootersController < ApplicationController
  load_and_authorize_resource
  before_action :set_kickscooter, only: [:show, :edit, :update, :destroy]

  # GET /kickscooters
  # GET /kickscooters.json
  def index
    @kickscooters = Kickscooter.preload(:manufacturer).paginate(:page => params[:page])
  end

  # GET /kickscooters/1
  # GET /kickscooters/1.json
  def show
  end

  # GET /kickscooters/new
  def new
    @kickscooter = Kickscooter.new
  end

  # GET /kickscooters/1/edit
  def edit
  end

  # POST /kickscooters
  # POST /kickscooters.json
  def create
    @kickscooter = Kickscooter.new(kickscooter_params)
    @kickscooter.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'kickscooter').first_or_create.id    
    respond_to do |format|
      if @kickscooter.save
        if params[:images]
          @kickscooter.gallery ||= Gallery.new
          params[:images].each do |image|
            @kickscooter.gallery.images.create(image: image)
          end
          unless @kickscooter.image_file_size
            @kickscooter.update(image: @kickscooter.gallery.images.first.image)
          end
        end
        format.html { redirect_to @kickscooter, notice: 'Kickscooter was successfully created.' }
        format.json { render :show, status: :created, location: @kickscooter }
      else
        format.html { render :new }
        format.json { render json: @kickscooter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kickscooters/1
  # PATCH/PUT /kickscooters/1.json
  def update
    respond_to do |format|
      if @kickscooter.update(kickscooter_params)
        if params[:images]
          @kickscooter.gallery ||= Gallery.new
          params[:images].each do |image|
            @kickscooter.gallery.images.create(image: image)
          end
          unless @kickscooter.image_file_size
            @kickscooter.update(image: @kickscooter.gallery.images.first.image)
          end
        end
        format.html { redirect_to @kickscooter, notice: 'Kickscooter was successfully updated.' }
        format.json { render :show, status: :ok, location: @kickscooter }
      else
        format.html { render :edit }
        format.json { render json: @kickscooter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kickscooters/1
  # DELETE /kickscooters/1.json
  def destroy
    @kickscooter.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/kickscooter", notice: 'Kickscooter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kickscooter
      @kickscooter = Kickscooter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kickscooter_params
      params.require(:kickscooter).permit(:kid_height, :wheels_material, :sloping_backrest, :manufacturer_id, :name, :price, :description, :image, :use, :electric_drive, :max_weight, :wheels_number, :wheels_diameter, :wheels_thickness, :wheels_material, :wheels_hardness, :inflatable_wheels, :bearings, :platform_material, :folding, :seat, :amortization, :front_break, :rear_break, :tilt_handle_control, :wheels_luminodiodes, :min_handlebar_height, :max_handlebar_height, :platform_length, :platform_width, :length, :weight, :horn, :basket, :footboard, :belt, :display, :hit)
    end
end
