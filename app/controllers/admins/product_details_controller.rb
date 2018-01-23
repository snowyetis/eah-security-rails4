class Admins::ProductDetailsController < ApplicationController
  before_action :set_product_detail, only: [:show, :edit, :update, :destroy]

  def edit
    
  end

  def update
    respond_to do |format|
      if @product_detail.update(product_detail_params)
        format.html { redirect_to @product_detail, notice: 'Product detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_detail }
      else
        format.html { render :edit }
        format.json { render json: @product_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_product_detail
      @product_detail = ProductDetail.find(params[:id])
    end

    def product_detail_params
      params.fetch(:product_detail, {})
    end

end
