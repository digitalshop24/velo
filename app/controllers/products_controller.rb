class ProductsController < ApplicationController
  def search
    if params[:model].in? Manufacturer::CATEGORIES.keys.map(&:to_s)
      @category = params[:model].to_sym
      @table = params[:model].downcase.pluralize
      fp, lp = params[:query].split(' ').first, params[:query].split(' ').last
      @products = params[:model].capitalize.constantize.joins(:manufacturer).
        where("lower(#{@table}.name) LIKE lower(:query) OR lower(manufacturers.name) LIKE lower(:query) OR (lower(manufacturers.name) LIKE lower(:fp) AND lower(#{@table}.name) LIKE lower(:lp))", { query: "%#{params[:query]}%", fp: "%#{fp}%", lp: "%#{lp}%" }).
        order('manufacturers.name').order("#{@table}.name").paginate(page: params[:page])
    end
  end
end
