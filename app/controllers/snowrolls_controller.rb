class SnowrollsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_snowroll, only: [:show, :edit, :update, :destroy]

  # GET /snowrolls
  # GET /snowrolls.json
  def index
    @snowrolls = Snowroll.preload(:manufacturer).paginate(:page => params[:page])
  end

  # GET /snowrolls/1
  # GET /snowrolls/1.json
  def show
  end

  # GET /snowrolls/new
  def new
    @snowroll = Snowroll.new
  end

  # GET /snowrolls/1/edit
  def edit
  end

  # POST /snowrolls
  # POST /snowrolls.json
  def create
    parms = snowroll_params
    parms[:frame_color] = parms[:frame_color].split(', ') if parms[:frame_color]
    @snowroll = Snowroll.new(parms)
    @snowroll.manufacturer_id ||= Manufacturer.where(name: 'не указан', category: 'snowroll').first_or_create.id     
    respond_to do |format|
      if @snowroll.save
        if params[:images]
          @snowroll.gallery ||= Gallery.new
          params[:images].each do |image|
            @snowroll.gallery.images.create(image: image)
          end
          unless @snowroll.image_file_size
            @snowroll.update(image: @snowroll.gallery.images.first.image)
          end
        end
        format.html { redirect_to @snowroll, notice: 'Snowroll was successfully created.' }
        format.json { render :show, status: :created, location: @snowroll }
      else
        format.html { render :new }
        format.json { render json: @snowroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snowrolls/1
  # PATCH/PUT /snowrolls/1.json
  def update
    parms = snowroll_params
    parms[:frame_color] = parms[:frame_color].split(', ') if parms[:frame_color]
    respond_to do |format|
      if @snowroll.update(snowroll_params)
        if params[:images]
          @snowroll.gallery ||= Gallery.new
          params[:images].each do |image|
            @snowroll.gallery.images.create(image: image)
          end
          unless @snowroll.image_file_size
            @snowroll.update(image: @snowroll.gallery.images.first.image)
          end
        end
        format.html { redirect_to @snowroll, notice: 'Snowroll was successfully updated.' }
        format.json { render :show, status: :ok, location: @snowroll }
      else
        format.html { render :edit }
        format.json { render json: @snowroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snowrolls/1
  # DELETE /snowrolls/1.json
  def destroy
    @snowroll.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/manufacturers/category/snowroll", notice: 'Snowroll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snowroll
      @snowroll = Snowroll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snowroll_params
      params.require(:snowroll).permit(:price, :manufacturer_id, :name, :image, :description, :display, :seats_number, :carrying, :hit)
    end
end
