class SportgoodsSubcategoriesController < ApplicationController
  before_action :set_sportgoods_subcategory, only: [:show, :edit, :update, :destroy]

  # GET /sportgoods_subcategories
  # GET /sportgoods_subcategories.json
  def index
    @sportgoods_subcategories = SportgoodsSubcategory.paginate(:page => params[:page])
  end

  # GET /sportgoods_subcategories/1
  # GET /sportgoods_subcategories/1.json
  def show
  end

  # GET /sportgoods_subcategories/new
  def new
    @sportgoods_subcategory = SportgoodsSubcategory.new
  end

  # GET /sportgoods_subcategories/1/edit
  def edit
  end

  # POST /sportgoods_subcategories
  # POST /sportgoods_subcategories.json
  def create
    @sportgoods_subcategory = SportgoodsSubcategory.new(sportgoods_subcategory_params)

    respond_to do |format|
      if @sportgoods_subcategory.save
        format.html { redirect_to @sportgoods_subcategory, notice: 'Sportgoods subcategory was successfully created.' }
        format.json { render :show, status: :created, location: @sportgoods_subcategory }
      else
        format.html { render :new }
        format.json { render json: @sportgoods_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sportgoods_subcategories/1
  # PATCH/PUT /sportgoods_subcategories/1.json
  def update
    respond_to do |format|
      if @sportgoods_subcategory.update(sportgoods_subcategory_params)
        format.html { redirect_to @sportgoods_subcategory, notice: 'Sportgoods subcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @sportgoods_subcategory }
      else
        format.html { render :edit }
        format.json { render json: @sportgoods_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sportgoods_subcategories/1
  # DELETE /sportgoods_subcategories/1.json
  def destroy
    @sportgoods_subcategory.destroy
    respond_to do |format|
      format.html { redirect_to sportgoods_subcategories_url, notice: 'Sportgoods subcategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sportgoods_subcategory
      @sportgoods_subcategory = SportgoodsSubcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sportgoods_subcategory_params
      params.require(:sportgoods_subcategory).permit(:name, :sportgoods_category_id)
    end
end
