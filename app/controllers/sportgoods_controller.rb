class SportgoodsController < ApplicationController
  load_and_authorize_resource
  before_action :set_sportgood, only: [:show, :edit, :update, :destroy]

  # GET /sportgoods
  # GET /sportgoods.json
  def index
    @sportgoods = Sportgood.preload(:manufacturer, :sportgoods_category, :sportgoods_subcategory).paginate(:page => params[:page])
  end

  # GET /sportgoods/1
  # GET /sportgoods/1.json
  def show
  end

  # GET /sportgoods/new
  def new
    @sportgood = Sportgood.new
  end

  # GET /sportgoods/1/edit
  def edit
  end

  # POST /sportgoods
  # POST /sportgoods.json
  def create
    @sportgood = Sportgood.new(sportgood_params)
    @sportgood.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'sportgood').first_or_create.id
    respond_to do |format|
      if @sportgood.save
        if params[:images]
          @sportgood.gallery ||= Gallery.new
          params[:images].each do |image|
            @sportgood.gallery.images.create(image: image)
          end
          unless @sportgood.image_file_size
            @sportgood.update(image: @sportgood.gallery.images.first.image)
          end
        end
        format.html { redirect_to @sportgood, notice: 'Sportgood was successfully created.' }
        format.json { render :show, status: :created, location: @sportgood }
      else
        format.html { render :new }
        format.json { render json: @sportgood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sportgoods/1
  # PATCH/PUT /sportgoods/1.json
  def update
    respond_to do |format|
      if @sportgood.update(sportgood_params)
        if params[:images]
          @sportgood.gallery ||= Gallery.new
          params[:images].each do |image|
            @sportgood.gallery.images.create(image: image)
          end
          unless @sportgood.image_file_size
            @sportgood.update(image: @sportgood.gallery.images.first.image)
          end
        end
        format.html { redirect_to @sportgood, notice: 'Sportgood was successfully updated.' }
        format.json { render :show, status: :ok, location: @sportgood }
      else
        format.html { render :edit }
        format.json { render json: @sportgood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sportgoods/1
  # DELETE /sportgoods/1.json
  def destroy
    @sportgood.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/sportgood", notice: 'Sportgood was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sportgood
    @sportgood = Sportgood.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sportgood_params
    params.require(:sportgood).permit(:price, :manufacturer_id, :name, :image, :description, :display, :hit, :sportgoods_category_id, :sportgoods_subcategory_id)
  end
end
