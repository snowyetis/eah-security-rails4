class Quote < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  has_one :quote_detail
  has_one :questionaire
  has_many :products

  accepts_nested_attributes_for :questionaire
  accepts_nested_attributes_for :quote_detail

  :quote_type
  :user_id
  :approved
  :pending
  :rejected
  :created_at
  :updated_at

  def default_values
    self.rejected = rejected.presence || 'false'
    self.approved = approved.presence || 'false'
  end

end
