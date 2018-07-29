class Quote < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  has_one :quote_detail
  has_one :questionaire
  has_many :products
  has_many :requester_types
  has_many :status_types

  accepts_nested_attributes_for :questionaire
  accepts_nested_attributes_for :quote_detail

  :quote_type
  :user_id
  :status_type_id
  :created_at
  :updated_at

  def default_values
    self.status_type_id = 1
  end

end
