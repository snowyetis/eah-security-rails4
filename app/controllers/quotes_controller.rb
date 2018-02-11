class QuotesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_quote, only: [:show, :update, :destroy]
  # before_action :authenticate_admin!, except: [:index, :show]

  add_breadcrumb "Home", :home_index_path

  # GET /quotes
  # GET /quotes.json
  def index
    add_breadcrumb "Your Quotes"

    if current_admin
      @quotes = Quote.all
      @users = User.all
    else
      if user_signed_in? && current_user != []
        @quotes = current_user.quotes.all
      else
        respond_to do |format|
          format.html { redirect_to home_index_url, notice: "There are no quotes created under your account" }
          format.json { render notice: "There are no quotes created under your account", status: :unprocessable_entity }
        end
      end
    end
  end

  def show_quote
    add_breadcrumb "View Quote"
    respond_to do |format|
      format.js
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    add_breadcrumb "Create a Quote"

    @quote = Quote.new
    @quote.quote_detail.questionaire.build

  end

  # GET /quotes/1/edit
  def edit
    add_breadcrumb "Edit a Quote"
    # TODO Add to before_action, right?!
    @quote = Quote.find(params[:id])
    @questionaire = @quote.questionaire
    @quote_detail = @quote.quote_detail
    # @quote_detail = @quote.build_quote_detail
    @product = Product.find_by(id: @quote.product_id)

  end

  # POST /quotes
  # POST /quotes.json
  def create

    if current_admin.blank? && current_user.blank?
      flash[:notice] = 'You must be logged in to send a quote.'
      redirect_to home_index_path
    else

      @quote = current_user.quotes.build(quote_params)

      respond_to do |format|
        if @quote.save
          format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
          format.json { render :show, status: :created, location: @quote }
        else
          format.html { render :new }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      # params.fetch(:quote)
      params.require(:quote).permit(:quote_type, :user_id, :approved, :pending, :rejected, :product_id, quote_detail_attributes: [:quote_comments], questionaire_attributes: [ :user_id, :quote_id, :product_type, :comments])
    end
end
