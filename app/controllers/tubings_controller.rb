class TubingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_tubing, only: [:show, :edit, :update, :destroy]

  # GET /tubings
  # GET /tubings.json
  def index
    if params[:after]
      after = Date.parse(params[:after])
      @tubings = Tubing.where('created_at > ?', after).preload(:manufacturer).paginate(page: params[:page])
    else
      @tubings = Tubing.preload(:manufacturer).paginate(:page => params[:page])
    end
  end

  # GET /tubings/1
  # GET /tubings/1.json
  def show
  end

  # GET /tubings/new
  def new
    @tubing = Tubing.new
  end

  # GET /tubings/1/edit
  def edit
  end

  # POST /tubings
  # POST /tubings.json
  def create
    @tubing = Tubing.new(tubing_params)
    @tubing.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'tubing').first_or_create.id
    respond_to do |format|
      if @tubing.save
        if params[:images]
          @tubing.gallery ||= Gallery.new
          params[:images].each do |image|
            @tubing.gallery.images.create(image: image)
          end
          unless @tubing.image_file_size
            @tubing.update(image: @tubing.gallery.images.first.image)
          end
        end
        format.html { redirect_to @tubing, notice: 'Tubing was successfully created.' }
        format.json { render :show, status: :created, location: @tubing }
      else
        format.html { render :new }
        format.json { render json: @tubing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tubings/1
  # PATCH/PUT /tubings/1.json
  def update
    respond_to do |format|
      if @tubing.update(tubing_params)
        if params[:images]
          @tubing.gallery ||= Gallery.new
          params[:images].each do |image|
            @tubing.gallery.images.create(image: image)
          end
          unless @tubing.image_file_size
            @tubing.update(image: @tubing.gallery.images.first.image)
          end
        end
        format.html { redirect_to @tubing, notice: 'Tubing was successfully updated.' }
        format.json { render :show, status: :ok, location: @tubing }
      else
        format.html { render :edit }
        format.json { render json: @tubing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tubings/1
  # DELETE /tubings/1.json
  def destroy
    @tubing.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/tubing", notice: 'Tubing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tubing
    @tubing = Tubing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tubing_params
    params.require(:tubing).permit(:price, :name, :manufacturer_id, :bottom_material, :top_material, :diameter, :handles_type, :tow_rope, :description, :display, :hit)
  end
end
