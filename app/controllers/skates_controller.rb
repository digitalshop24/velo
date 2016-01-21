class SkatesController < ApplicationController
  before_action :set_skate, only: [:show, :edit, :update, :destroy]

  # GET /skates
  # GET /skates.json
  def index
    if params[:after]
      after = Date.parse(params[:after])
      @skates = Skate.where('created_at > ?', after).preload(:manufacturer).paginate(page: params[:page])
    else
      @skates = Skate.preload(:manufacturer).paginate(:page => params[:page])
    end
  end

  # GET /skates/1
  # GET /skates/1.json
  def show
  end

  # GET /skates/new
  def new
    @skate = Skate.new
  end

  # GET /skates/1/edit
  def edit
  end

  # POST /skates
  # POST /skates.json
  def create
    parms = skate_params
    parms[:color] = parms[:color].split(', ') if parms[:color]
    @skate = Skate.new(parms)
    @skate.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'skate').first_or_create.id
    respond_to do |format|
      if @skate.save
        if params[:images]
          @skate.gallery ||= Gallery.new
          params[:images].each do |image|
            @skate.gallery.images.create(image: image)
          end
          unless @skate.image_file_size
            @skate.update(image: @skate.gallery.images.first.image)
          end
        end
        format.html { redirect_to @skate, notice: 'Skate was successfully created.' }
        format.json { render :show, status: :created, location: @skate }
      else
        format.html { render :new }
        format.json { render json: @skate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skates/1
  # PATCH/PUT /skates/1.json
  def update
    parms = skate_params
    parms[:color] = parms[:color].split(', ') if parms[:color]
    respond_to do |format|
      if @skate.update(parms)
        if params[:images]
          @skate.gallery ||= Gallery.new
          params[:images].each do |image|
            @skate.gallery.images.create(image: image)
          end
          unless @skate.image_file_size
            @skate.update(image: @skate.gallery.images.first.image)
          end
        end
        format.html { redirect_to @skate, notice: 'Skate was successfully updated.' }
        format.json { render :show, status: :ok, location: @skate }
      else
        format.html { render :edit }
        format.json { render json: @skate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skates/1
  # DELETE /skates/1.json
  def destroy
    @skate.destroy
    respond_to do |format|
      format.html { redirect_to skates_url, notice: 'Skate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_skate
    @skate = Skate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def skate_params
    params.require(:skate).permit(:manufacturer_id, :name, :price, :description, :display, :image, :hit)
  end
end
