class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product, only: [:show]
  add_breadcrumb "Home", :root_path

  def index
    if user_signed_in?
      @quote = current_user.quotes.new
    else
      @quote = Quote.new
    end

    @product_top = Product.first
    @product_middle =  Product.second
    @product_bottom =  Product.third
    @questionaire = @quote.build_questionaire
    @quote_detail = @quote.build_quote_detail

    add_breadcrumb "Our Services", products_path

    respond_to do |format|
      format.js {}
      format.html
    end
  end

  def new
    @product = Product.new
  end

  def edit
    if !current_admin.blank?
      # @quote = Quote.all

      @product = Product.product_details.all
      # @product_top = Product.product_details.first
      # @product_middle =  Product.product_details.second
      # @product_bottom =  Product.product_details.third

      # @questionaire = @quote.build_questionaire
      # @quote_detail = @quote.build_quote_detail
    end
  end

  def show
    respond_to do |format|
      format.js {}
      format.html
    end
  end

  def submit_questionaire
    @quote = Quote.new(params[:combo_params])
    # add_breadcrumb "View", product_path

    if @quote.save
      flash[:notice]  = "Quote sent"
      redirect_to home_index_path
    else
      flash[:danger] = "Error!"
    end
  end

  def send_quote_request
    if user_signed_in?
      @role = Role.find(params[:id])
      case @role.Id
        when 1
          QuoteMailer.fire_door_quote_request
        when 2
          QuoteMailer.security_solutions_quote_request
        when 3
          QuoteMailer.locksmith_quote_request
        else
          flash[:error] = "Not found"
        end
      else
        flash[:error] = "You must be a registered user before requesting a quote."
      end

  end

  private

  def combo_params
    params.require(:quote).permit(:quote_type ,:user_id, :pending, questionaire: [ :user_id, :quote_id, :product_type, :comments ])
  end

  def questionaire_params
    params.require(:questionaire).permit(:user_id, :quote_id, :product_type, :comments)
  end

  def quote_params
    params.require(:quote).permit(:quote_type, :user_id, :approved, :pending, :rejected)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
