class ManufacturersController < ApplicationController
  load_and_authorize_resource
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  PER_PAGE = 100
  # GET /manufacturers
  # GET /manufacturers.json
  def index
    @category = params[:category]
    if @category
      @manufacturers = Manufacturer.where(category: @category).order(:name).paginate(page: params[:page], per_page: PER_PAGE)
    else
      @manufacturers = Manufacturer.order(:name).paginate(page: params[:page], per_page: PER_PAGE)
    end
  end

  def change_display
    manufacturer = Manufacturer.find(params[:id])
    category = manufacturer.category.downcase.pluralize.to_sym
    if params[:flag] == '1'
      flag = true
    elsif params[:flag] == '0'
      flag = false
    else
      redirect_to :back, notice: 'Ошибка'
    end
    manufacturer.send(category).each do |product|
      product.update(display: flag)
    end
    redirect_to :back, notice: "Товары производителя #{manufacturer.name} теперь #{ 'не ' unless flag }отображаются"
  end

  # GET /manufacturers/1
  # GET /manufacturers/1.json
  def show
    @per_page = PER_PAGE
    @category = @manufacturer.category
  end

  # GET /manufacturers/new
  def new
    @manufacturer = Manufacturer.new
  end

  # GET /manufacturers/1/edit
  def edit
  end

  # POST /manufacturers
  # POST /manufacturers.json
  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    respond_to do |format|
      if @manufacturer.save
        format.html { redirect_to @manufacturer, notice: 'Производитель создан' }
        format.json { render :show, status: :created, location: @manufacturer }
      else
        format.html { render :new }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manufacturers/1
  # PATCH/PUT /manufacturers/1.json
  def update
    respond_to do |format|
      if @manufacturer.update(manufacturer_params)
        format.html { redirect_to @manufacturer, notice: 'Производитель обновлен' }
        format.json { render :show, status: :ok, location: @manufacturer }
      else
        format.html { render :edit }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manufacturers/1
  # DELETE /manufacturers/1.json
  def destroy
    @manufacturer.destroy
    respond_to do |format|
      format.html { redirect_to manufacturers_url, notice: 'Производитель удален' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manufacturer_params
      params.require(:manufacturer).permit(:name, :category, :rate)
    end
end
