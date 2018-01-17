class Admins::ProductsController < ApplicationController
  load_and_authorize_resource

  # TODO Change upon creation of Admin Home page.
  add_breadcrumb "Home", :root_path

  before_action :authenticate_admin!

  def index
    add_breadcrumb "Administration Product Editor"

    @products = Product.includes(:product_details)
  end

  def new
    add_breadcrumb "Create a Product"

    @product = Product.new
    @product.product_details.build
  end

  def edit
    add_breadcrumb "Create a Product"

    if !current_admin.blank?
      @product = Product.product_details.all
    end
  end

  def update

  end

  def create

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
