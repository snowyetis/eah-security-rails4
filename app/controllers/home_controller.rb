class HomeController < ApplicationController

  def index
    @quote = current_user.quotes.new
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

  def send_quote_request
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
