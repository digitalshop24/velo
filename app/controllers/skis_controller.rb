class SkisController < ApplicationController
  load_and_authorize_resource
  before_action :set_ski, only: [:show, :edit, :update, :destroy]

  # GET /skis
  # GET /skis.json
  def index
    @category = 'ski'
    if params[:after]
      after = Date.parse(params[:after])
      @skis = Ski.where('created_at > ?', after).preload(:manufacturer).paginate(page: params[:page])
    else
      @skis = Ski.preload(:manufacturer).paginate(:page => params[:page])
    end
  end

  # GET /skis/1
  # GET /skis/1.json
  def show
  end

  # GET /skis/new
  def new
    @ski = Ski.new
  end

  # GET /skis/1/edit
  def edit
  end

  # POST /skis
  # POST /skis.json
  def create
    parms = ski_params
    parms[:color] = parms[:color].split(', ') if parms[:color]
    @ski = Ski.new(parms)
    @ski.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'ski').first_or_create.id
    respond_to do |format|
      if @ski.save
        if params[:images]
          @ski.gallery ||= Gallery.new
          params[:images].each do |image|
            @ski.gallery.images.create(image: image)
          end
          unless @ski.image_file_size
            @ski.update(image: @ski.gallery.images.first.image)
          end
        end
        format.html { redirect_to @ski, notice: 'Ski was successfully created.' }
        format.json { render :show, status: :created, location: @ski }
      else
        format.html { render :new }
        format.json { render json: @ski.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skis/1
  # PATCH/PUT /skis/1.json
  def update
    parms = ski_params
    parms[:color] = parms[:color].split(', ') if parms[:color]
    respond_to do |format|
      if @ski.update(parms)
        if params[:images]
          @ski.gallery ||= Gallery.new
          params[:images].each do |image|
            @ski.gallery.images.create(image: image)
          end
          unless @ski.image_file_size
            @ski.update(image: @ski.gallery.images.first.image)
          end
        end
        format.html { redirect_to @ski, notice: 'Ski was successfully updated.' }
        format.json { render :show, status: :ok, location: @ski }
      else
        format.html { render :edit }
        format.json { render json: @ski.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skis/1
  # DELETE /skis/1.json
  def destroy
    @ski.destroy
    respond_to do |format|
      format.html { redirect_to skis_url, notice: 'Ski was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ski
    @ski = Ski.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ski_params
    params.require(:ski).permit(:video, :manufacturer_id, :name, :price, :old_price, :poles, :grid, :size, :description, :display, :image, :hit)
  end
end
