class BikesController < ApplicationController
  load_and_authorize_resource
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  # GET /bikes
  # GET /bikes.json
  def index
    @category = 'bike'
    if params[:after]
      after = Date.parse(params[:after])
      @bikes = Bike.where('created_at > ?', after).preload(:manufacturer).paginate(page: params[:page])
    else
      @bikes = Bike.preload(:manufacturer).paginate(page: params[:page])
    end
  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
  end

  # GET /bikes/1/edit
  def edit
  end

  # POST /bikes
  # POST /bikes.json
  def create
    parms = bike_params
    parms[:frame_color] = parms[:frame_color].split(', ') if parms[:frame_color]
    @bike = Bike.new(parms)
    @bike.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'bike').first_or_create.id
    respond_to do |format|
      if @bike.save
        if params[:images]
          @bike.gallery ||= Gallery.new
          params[:images].each do |image|
            @bike.gallery.images.create(image: image)
          end
          unless @bike.image_file_size
            @bike.update(image: @bike.gallery.images.first.image)
          end
        end

        format.html { redirect_to @bike, notice: 'Bike was successfully created.' }
        format.json { render :show, status: :created, location: @bike }
      else
        format.html { render :new }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bikes/1
  # PATCH/PUT /bikes/1.json
  def update
    respond_to do |format|
      parms = bike_params
      parms[:frame_color] = parms[:frame_color].split(', ') if parms[:frame_color]
      if @bike.update(parms)
        if params[:images]
          @bike.gallery ||= Gallery.new
          params[:images].each do |image|
            @bike.gallery.images.create(image: image)
          end
          unless @bike.image_file_size
            @bike.update(image: @bike.gallery.images.first.image)
          end
        end
        format.html { redirect_to @bike, notice: 'Bike was successfully updated.' }
        format.json { render :show, status: :ok, location: @bike }
      else
        format.html { render :edit }
        format.json { render json: @bike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    @bike.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/bike", notice: 'Bike was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bike
    @bike = Bike.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bike_params
    params.require(:bike).permit(:video, :manufacturer_id, :name, :display, :image, :price, :old_price, :year, :bike_class, :bike_type, :weight, :description, :frame_type, :handlebar, :chain, :fork, :pomp, :rims, :saddle, :roga, :grips, :light, :carriage, :basket, :shifters, :handlebar_type, :luggage_rack, :footboard, :tires, :fork_type, :saddle_type, :frame_color, :chain_protection, :shifters_type, :pedal_type, :handlebar_width, :tires_width, :rear_fender, :grips_model, :double_rims, :wheels_diameter, :rear_brake, :rear_hub, :frame_material, :folding_frame, :front_fender, :front_hub, :front_brake, :crank_system, :amortization_type, :transmission_type, :fork_locking, :rims_material, :pedal_material, :absorber_length, :saddle_amortization, :horn, :rear_absorber, :tread, :fork_rod_diameter, :rear_brake_type, :rearview_mirror, :ratchet, :rear_derailleur, :speeds_number, :front_break_type, :front_derailleur, :brake_disks_diameter, :stars_number_cassette, :stars_number_system, :teeth_number_cassette, :teeth_number_system, :hit)
  end
end
