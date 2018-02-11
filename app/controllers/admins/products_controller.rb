class Admins::ProductsController < ApplicationController
  load_and_authorize_resource
  # TODO Change upon creation of Admin Home page.
  add_breadcrumb "Home", :root_path
  before_action :authenticate_admin!
  before_action :set_product, only: [:destroy]

  def index
    add_breadcrumb "Template Manager"

    @product = Product.new
    @products = Product.includes(:product_details)
    
    # @product = Product.find_by(id: @quote.product_id)
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
    @products = Product.all

    respond_to do |format|
      if @product.save
        format.html { redirect_to admins_products_index_url, notice: 'The product was successfully created.' }
        format.json { render :index, status: :created, location: @products }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
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

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admins_products_index_url, notice: 'The product was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

    def product_params
      params.require(:product).permit(:id, :product_type)
    end

    def set_product
      @product = Product.find(params[:id])
    end



end
