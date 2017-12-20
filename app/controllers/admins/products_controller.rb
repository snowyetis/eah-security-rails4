class Admins::ProductsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_admin!

  # before_action :update, :only => [:get_bulk_products, :save_bulk_products]

  def index
    @products = Product.includes(:product_details)
    # @products = Product.all
    # @products = Product.group(:product_id)
    # @products = Product.joins(:product_details).group("product_id")
  end

  def new
    add_breadcrumb "Create a Product"
    @product = Product.new

    @product.product_detail.build
  end

  def edit
    if !current_admin.blank?

      @product = Product.product_details.all

      # @quote = Quote.find(params[:id])
      # @questionaire = @quote.questionaire
      # @quote_detail = @quote.quote_detail
    end
  end

  def save_bulk_products
    result = Product.update(params[:products].keys, params[:products].values).reject{ |p| p.errors.empty? }

    if result.empty?
      flash[:notice] = "Product templates updated"
      redict_to  products_get_bulk_products_path(page: params[:page])
    else
      product_ids = result.collect { |i| i.id }
      flash[:error] = "Error(s) occurred updating product(s): #{product_ids.join ','}"
      redirect_to products_get_bulk_products_path(page: params[:page])
    end

  end


end
