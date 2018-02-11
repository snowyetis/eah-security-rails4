class HomeController < ApplicationController
  before_action :hide_nav, only: [:exit, :pending]

  def index
    set_middle_nav
    if user_signed_in?
      @quote = current_user.quotes.new
    else
      @quote = Quote.new
    end

    # TODO Verify if this is needed still... It should not be
    @product_top = Product.first
    @product_middle =  Product.second
    @product_bottom =  Product.third
    @questionaire = @quote.build_questionaire
    @quote_detail = @quote.build_quote_detail

  end

  def submit_questionaire
    @quote = Quote.new(params[:combo_params])
    if @quote.save
      flash[:notice]  = "Quote sent"
      redirect_to home_index_path
    else
      flash[:danger] = "Error!"
    end
  end

  def about
  end

  def pending
  end

  def exit
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

end
