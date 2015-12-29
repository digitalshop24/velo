class SportgoodsCategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :set_sportgoods_category, only: [:show, :edit, :update, :destroy]

  # GET /sportgoods_categories
  # GET /sportgoods_categories.json
  def index
    @sportgoods_categories = SportgoodsCategory.paginate(:page => params[:page])
  end

  # GET /sportgoods_categories/1
  # GET /sportgoods_categories/1.json
  def show
  end

  # GET /sportgoods_categories/new
  def new
    @sportgoods_category = SportgoodsCategory.new
  end

  # GET /sportgoods_categories/1/edit
  def edit
  end

  # POST /sportgoods_categories
  # POST /sportgoods_categories.json
  def create
    @sportgoods_category = SportgoodsCategory.new(sportgoods_category_params)

    respond_to do |format|
      if @sportgoods_category.save
        format.html { redirect_to @sportgoods_category, notice: 'Sportgoods category was successfully created.' }
        format.json { render :show, status: :created, location: @sportgoods_category }
      else
        format.html { render :new }
        format.json { render json: @sportgoods_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sportgoods_categories/1
  # PATCH/PUT /sportgoods_categories/1.json
  def update
    respond_to do |format|
      if @sportgoods_category.update(sportgoods_category_params)
        format.html { redirect_to @sportgoods_category, notice: 'Sportgoods category was successfully updated.' }
        format.json { render :show, status: :ok, location: @sportgoods_category }
      else
        format.html { render :edit }
        format.json { render json: @sportgoods_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sportgoods_categories/1
  # DELETE /sportgoods_categories/1.json
  def destroy
    @sportgoods_category.destroy
    respond_to do |format|
      format.html { redirect_to sportgoods_categories_url, notice: 'Sportgoods category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sportgoods_category
      @sportgoods_category = SportgoodsCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sportgoods_category_params
      params.require(:sportgoods_category).permit(:name)
    end
end
