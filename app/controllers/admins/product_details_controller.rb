class Admins::ProductDetailsController < ApplicationController
  before_action :set_product_detail, only: [:show, :update, :destroy]

  def show

  end

  def edit
    @products = Product.where("id = ?", params[:product_id])
    # TODO So bad fix later
    @product = @products.first

    @product_detail = ProductDetail.find(params[:id])
    # Get the product detail records belonging to the parent Product.
    # @product_details_for_modal = ProductDetail.where("product_id = ?", params[:product_id])
    # @product_details_for_modal_paged = @product_details_for_modal.order("id ASC")

    # respond_to do |format|
    #   format.js
    #   format.html { render laytout: !request.xhr? }
    # end
  end

  def update
    respond_to do |format|
      if @product_detail.update(product_detail_params)
        format.html { flash.now[:notice] = @product_detail.model_number + "has been updated" }
        format.js { flash.now[:notice] = @product_detail.model_number + "has been updated", @products }
      else
        format.js { render 'index' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product_detail.destroy(@product_detail.id)
        format.js { flash.now[:notice] = @product_detail.model_number + "has been updated", @products }
      else
        format.js { render 'index' }
      end
    end
  end

  private

    def set_product_detail
      @product_detail = ProductDetail.find(params[:id])
    end

    def get_proudcts_and_details
      @products = Product.where("id = ?", params[:product_id])
      # TODO So bad fix later
      @product = @products.first
    end

    def product_detail_params
      params.require(:product_detail).permit(:id, :model_number, :model_description, :product_detail_type, :created_at, :updated_at, :product_id)
    end

end
