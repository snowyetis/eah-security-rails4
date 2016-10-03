class QuoteMailer < ApplicationMailer

  # TODO: Complete quote e-mail notifications
  def fire_door_quote_request(quote)
    @quote = quote
    @url = "http://localhost:3000/quotes"

  end

  def security_solutions_quote_request(quote)
    @quote = quote
    @url = "http://localhost:3000/quotes"

  end

  def locksmith_quote_request(quote)
    @quote = quote
    @url = "http://localhost:3000/quotes"
    
  end

end
