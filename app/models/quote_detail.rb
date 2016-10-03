class QuoteDetail < ActiveRecord::Base
  belongs_to :quote
  has_many :users, through: :quote

  :quote_id
  :quote_comments
  :approved_by
  :rejected_by
  :rejected_reason
  :estimate
end
