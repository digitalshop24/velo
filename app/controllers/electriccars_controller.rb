class ElectriccarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_electriccar, only: [:show, :edit, :update, :destroy]

  # GET /electriccars/1
  # GET /electriccars/1.json
  def show
  end

  # GET /electriccars/new
  def new
    @electriccar = Electriccar.new
  end

  # GET /electriccars/1/edit
  def edit
  end

  # POST /electriccars
  # POST /electriccars.json
  def create
    @electriccar = Electriccar.new(electriccar_params)
    @electriccar.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'electriccar').first_or_create.id
    respond_to do |format|
      if @electriccar.save
        if params[:images]
          @electriccar.gallery ||= Gallery.new
          params[:images].each do |image|
            @electriccar.gallery.images.create(image: image)
          end
          unless @electriccar.image_file_size
            @electriccar.update(image: @electriccar.gallery.images.first.image)
          end
        end
        format.html { redirect_to @electriccar, notice: 'Electriccar was successfully created.' }
        format.json { render :show, status: :created, location: @electriccar }
      else
        format.html { render :new }
        format.json { render json: @electriccar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /electriccars/1
  # PATCH/PUT /electriccars/1.json
  def update
    respond_to do |format|
      if @electriccar.update(electriccar_params)
        if params[:images]
          @electriccar.gallery ||= Gallery.new
          params[:images].each do |image|
            @electriccar.gallery.images.create(image: image)
          end
          unless @electriccar.image_file_size
            @electriccar.update(image: @electriccar.gallery.images.first.image)
          end
        end
        format.html { redirect_to @electriccar, notice: 'Electriccar was successfully updated.' }
        format.json { render :show, status: :ok, location: @electriccar }
      else
        format.html { render :edit }
        format.json { render json: @electriccar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /electriccars/1
  # DELETE /electriccars/1.json
  def destroy
    @electriccar.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/electriccar", notice: 'Electriccar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_electriccar
    @electriccar = Electriccar.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def electriccar_params
    params.require(:electriccar).permit(:video, :manufacturer_id, :name, :price, :old_price, :age, :remote_control, :max_speed, :battery, :engine, :work_time, :charging_time, :max_weight, :weight, :sizes, :light, :seat_belt, :rearview_mirror, :description, :image, :display, :hit)
  end
end
