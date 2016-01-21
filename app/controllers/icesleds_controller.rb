class IcesledsController < ApplicationController
  load_and_authorize_resource
  before_action :set_icesled, only: [:show, :edit, :update, :destroy]

  # GET /icesleds
  # GET /icesleds.json
  def index
    if params[:after]
      after = Date.parse(params[:after])
      @icesleds = Icesled.where('created_at > ?', after).preload(:manufacturer).paginate(page: params[:page])
    else
      @icesleds = Icesled.preload(:manufacturer).order(:name).paginate(:page => params[:page])
    end
  end

  # GET /icesleds/1
  # GET /icesleds/1.json
  def show
  end

  # GET /icesleds/new
  def new
    @icesled = Icesled.new
  end

  # GET /icesleds/1/edit
  def edit
  end

  # POST /icesleds
  # POST /icesleds.json
  def create
    @icesled = Icesled.new(icesled_params)
    @icesled.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'icesled').first_or_create.id
    respond_to do |format|
      if @icesled.save
        if params[:images]
          @icesled.gallery ||= Gallery.new
          params[:images].each do |image|
            @icesled.gallery.images.create(image: image)
          end
          unless @icesled.image_file_size
            @icesled.update(image: @icesled.gallery.images.first.image)
          end
        end
        format.html { redirect_to @icesled, notice: 'Icesled was successfully created.' }
        format.json { render :show, status: :created, location: @icesled }
      else
        format.html { render :new }
        format.json { render json: @icesled.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /icesleds/1
  # PATCH/PUT /icesleds/1.json
  def update
    respond_to do |format|
      if @icesled.update(icesled_params)
        if params[:images]
          @icesled.gallery ||= Gallery.new
          params[:images].each do |image|
            @icesled.gallery.images.create(image: image)
          end
          unless @icesled.image_file_size
            @icesled.update(image: @icesled.gallery.images.first.image)
          end
        end
        format.html { redirect_to @icesled, notice: 'Icesled was successfully updated.' }
        format.json { render :show, status: :ok, location: @icesled }
      else
        format.html { render :edit }
        format.json { render json: @icesled.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /icesleds/1
  # DELETE /icesleds/1.json
  def destroy
    @icesled.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/icesled", notice: 'Icesled was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_icesled
    @icesled = Icesled.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def icesled_params
    params.require(:icesled).permit(:price, :manufacturer_id, :name, :image, :description, :material, :handles, :length, :display, :hit)
  end
end
