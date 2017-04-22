class QuoteMailer < ApplicationMailer

  # TODO: Complete quote e-mail notifications
  def fire_door_quote_request(quote)
    @quote = quote
    @url =  request.original_url + "quotes"

  end

  def security_solutions_quote_request(quote)
    @quote = quote
    @url =  request.original_url + "quotes"

  end

  def locksmith_quote_request(quote)
    @quote = quote
    @url = request.original_url + "quotes"

  end

end
